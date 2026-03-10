import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../backend/schema/enums/enums.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/validators/offer_status_transition.dart';
import '../datasources/offer_remote_datasource.dart';
import '../models/offer_model.dart';
import '../models/offer_notification_model.dart';
import '../models/offer_revision_model.dart';
import 'offer_notification_repository.dart';
import 'offer_revision_repository.dart';

@lazySingleton
class OfferRepository {
  final OfferRemoteDataSource _remote;
  final OfferRevisionRepository _revisionRepo;
  final OfferNotificationRepository _notificationRepo;

  OfferRepository(this._remote, this._revisionRepo, this._notificationRepo);

  dynamic _jsonify(dynamic value) {
    if (value == null ||
        value is String ||
        value is num ||
        value is bool ||
        value is DateTime) {
      return value;
    }
    if (value is List) {
      return value.map(_jsonify).toList();
    }
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _jsonify(v)));
    }
    try {
      // Freezed/json_serializable models expose `toJson()`.
      return _jsonify((value as dynamic).toJson());
    } catch (_) {
      return value;
    }
  }

  Map<String, dynamic> _toJsonMap(Map<String, dynamic> map) {
    final json = _jsonify(map);
    if (json is Map<String, dynamic>) return json;
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v));
    }
    return Map<String, dynamic>.from(map);
  }

  String _userDisplayName(Map<String, dynamic> user) {
    final displayName = _s(user['display_name']) ?? _s(user['displayName']);
    if (displayName != null) return displayName;
    final firstName = _s(user['first_name']) ?? _s(user['firstName']) ?? '';
    final lastName = _s(user['last_name']) ?? _s(user['lastName']) ?? '';
    return '$firstName $lastName'.trim();
  }

  Future<Map<String, dynamic>> _enrichCreateOfferData(
    Map<String, dynamic> offerData,
    String requesterId,
  ) async {
    final enriched = _toJsonMap(offerData);
    final parties = _asMap(enriched['parties']);
    final buyer = _asMap(parties['buyer']);
    final agent = _asMap(parties['agent']);

    final buyerId = _s(enriched['buyerId']) ?? _s(buyer['id']) ?? requesterId;
    final currentAgentId =
        _s(enriched['agentId']) ?? _s(enriched['agent_id']) ?? _s(agent['id']);

    if (currentAgentId == null || currentAgentId.isEmpty) {
      final relationship =
          await _remote.getRelationshipForSubjectUid(subjectUid: buyerId);
      final relationshipData = _asMap(relationship?['relationship']);
      final resolvedAgentId = _s(relationshipData['agentUid']);

      if (resolvedAgentId != null && resolvedAgentId.isNotEmpty) {
        final agentUser = await _remote.getUserByUid(uid: resolvedAgentId);
        final updatedParties = Map<String, dynamic>.from(parties)
          ..['agent'] = {
            'id': resolvedAgentId,
            'name': agentUser == null ? '' : _userDisplayName(agentUser),
            'phoneNumber': agentUser == null
                ? ''
                : (_s(agentUser['phone_number']) ??
                    _s(agentUser['phoneNumber']) ??
                    ''),
            'email': agentUser == null ? '' : (_s(agentUser['email']) ?? ''),
          };

        enriched['parties'] = updatedParties;
        enriched['agentId'] = resolvedAgentId;
      }
    }

    return enriched;
  }

  Future<Either<Failure, List<OfferModel>>> getUserOffers({
    required String requesterId,
    String? propertyId,
    String? buyerId,
    String? sellerId,
    String? status,
  }) async {
    try {
      final data = await _remote.getUserOffers(
        requesterId: requesterId,
        propertyId: propertyId,
        buyerId: buyerId,
        sellerId: sellerId,
        status: status,
      );
      return Right(data.map(_toOfferModel).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<OfferModel>>> getAgentOffers({
    required String requesterId,
    String? status,
  }) async {
    try {
      final data = await _remote.getAgentOffers(
          requesterId: requesterId, status: status);
      return Right(data.map(_toOfferModel).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createOffer({
    required Map<String, dynamic> offerData,
    required String requesterId,
  }) async {
    try {
      final serializedOfferData =
          await _enrichCreateOfferData(offerData, requesterId);
      final buyerId = _s(serializedOfferData['buyerId']);
      final agentId = _s(serializedOfferData['agentId']) ??
          _s(_asMap(_asMap(serializedOfferData['parties'])['agent'])['id']);

      // Buyer-direct offers must remain attached to an assigned agent.
      if (buyerId == requesterId && (agentId == null || agentId.isEmpty)) {
        return const Left(ValidationFailure(
          message:
              'No assigned agent was found for this buyer. Please connect with an agent before submitting an offer.',
        ));
      }

      final result = await _remote.createOffer(
          offerData: serializedOfferData, requesterId: requesterId);

      await _createNotificationsForChange(
        offerBefore: null,
        offerAfter: result,
        actorUserId: requesterId,
        actorName: 'User $requesterId',
        revisionCreated: false,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateOffer({
    required Map<String, dynamic> offerData,
    required String requesterId,
    String requestorName = '',
    String requestorRole = '',
    String changeNotes = '',
    bool trackRevision = true,
  }) async {
    try {
      final serializedOfferData = _toJsonMap(offerData);
      final offerId = serializedOfferData['offerID'] as String? ??
          serializedOfferData['id'] as String? ??
          '';

      // Fetch current offer state for comparison if revision tracking is enabled
      Map<String, dynamic>? oldOfferState;
      if (trackRevision && offerId.isNotEmpty) {
        try {
          oldOfferState = await _remote.getOfferById(offerId: offerId) ??
              <String, dynamic>{};
        } catch (e) {
          // If we can't fetch old state, proceed without revision tracking
          trackRevision = false;
        }
      }

      // Validate status transitions if status is being changed
      if (oldOfferState != null && oldOfferState.isNotEmpty) {
        final oldStatus = _parseStatus(oldOfferState['status']);
        final newStatus = _parseStatus(serializedOfferData['status']);

        if (oldStatus != null && newStatus != null && oldStatus != newStatus) {
          // Extract the 'id' from a party value that may be a Map, a model
          // object with an `id` property, or null.
          String? _partyId(dynamic val) {
            if (val == null) return null;
            if (val is Map) return val['id'] as String?;
            // BuyerModel / freezed objects expose an `id` getter
            try {
              return (val as dynamic).id as String?;
            } catch (_) {
              return null;
            }
          }

          // `parties` may be nested or flat depending on the source
          // (OfferProcessSheet nests under 'parties', OfferModel.toJson() is flat).
          final parties = serializedOfferData['parties'];
          final partiesMap =
              parties is Map<String, dynamic> ? parties : <String, dynamic>{};

          // Normalise IDs: strip Firestore path prefix (e.g. "/users/uid" → "uid")
          String? _normaliseId(String? raw) {
            if (raw == null || raw.isEmpty) return null;
            return raw.contains('/') ? raw.split('/').last : raw;
          }

          final buyerId = _normaliseId(_partyId(partiesMap['buyer']) ??
                  _partyId(serializedOfferData['buyer'])) ??
              _normaliseId(serializedOfferData['buyerId'] as String?);
          final sellerId = _normaliseId(_partyId(partiesMap['seller']) ??
                  _partyId(serializedOfferData['seller'])) ??
              _normaliseId(serializedOfferData['sellerId'] as String?);
          final agentId = _normaliseId(_partyId(partiesMap['agent']) ??
              _partyId(serializedOfferData['agent']));

          // Validate the transition
          final validation = OfferStatusTransition.validateTransition(
            currentStatus: oldStatus,
            newStatus: newStatus,
            userId: requesterId,
            sellerId: sellerId,
            buyerId: buyerId,
            agentId: agentId,
            offerData: serializedOfferData,
          );

          if (validation.isLeft()) {
            // Return the failure from validation
            return validation.fold(
              (failure) => Left(failure),
              (status) => Right(<String, dynamic>{}), // Unreachable
            );
          }
        }
      }

      // Update the offer
      final result = await _remote.updateOffer(
        offerData: serializedOfferData,
        requesterId: requesterId,
      );

      // Create revision record if tracking is enabled and we have old state
      if (trackRevision && oldOfferState != null && oldOfferState.isNotEmpty) {
        await _revisionRepo.createRevisionFromComparison(
          offerId: offerId,
          oldOffer: oldOfferState,
          newOffer: result,
          userId: requesterId,
          userName: requestorName.isEmpty ? 'User $requesterId' : requestorName,
          userRole: requestorRole.isEmpty ? 'unknown' : requestorRole,
          changeNotes: changeNotes,
        );
      }

      await _createNotificationsForChange(
        offerBefore: oldOfferState,
        offerAfter: result,
        actorUserId: requesterId,
        actorName: requestorName.isEmpty ? 'User $requesterId' : requestorName,
        revisionCreated: trackRevision,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // -- Compare Offers (24 tracked fields) --

  static const _pricingFields = ['list_price', 'purchase_price'];
  static const _financialFields = [
    'loan_type',
    'down_payment_amount',
    'loan_amount',
    'deposit_amount',
    'deposit_type',
    'additional_earnest',
    'option_fee',
    'credit_request',
    'coverage_amount',
  ];
  static const _conditionFields = [
    'property_condition',
    'pre_approval',
    'survey'
  ];
  static const _titleFields = ['company_name', 'choice'];
  static const _contactFields = ['name', 'phone_number', 'email'];
  static const _addressFields = [
    'street_number',
    'street_name',
    'city',
    'state',
    'zip'
  ];

  dynamic _firstValue(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      if (map.containsKey(key)) return map[key];
    }
    return null;
  }

  dynamic _at(Map<String, dynamic> map, String snakeKey) {
    final camel = snakeKey.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (m) => m.group(1)!.toUpperCase(),
    );
    return _firstValue(map, [snakeKey, camel]);
  }

  bool compareOffers(Map<String, dynamic> newO, Map<String, dynamic> oldO) {
    final np = _asMap(newO['pricing']);
    final op = _asMap(oldO['pricing']);
    for (final f in _pricingFields) {
      if (_d(_at(np, f), _at(op, f))) return true;
    }

    final nf = _asMap(newO['financials']);
    final of2 = _asMap(oldO['financials']);
    for (final f in _financialFields) {
      if (_d(_at(nf, f), _at(of2, f))) return true;
    }

    if (_d(_firstValue(newO, ['closing_date', 'closingDate']),
        _firstValue(oldO, ['closing_date', 'closingDate']))) {
      return true;
    }
    if (_d(_firstValue(newO, ['closing_days', 'closingDays']),
        _firstValue(oldO, ['closing_days', 'closingDays']))) {
      return true;
    }

    final nc = _asMap(newO['conditions']);
    final oc = _asMap(oldO['conditions']);
    for (final f in _conditionFields) {
      if (_d(_at(nc, f), _at(oc, f))) return true;
    }

    final nt = _asMap(newO['title_company'] ?? newO['titleCompany']);
    final ot = _asMap(oldO['title_company'] ?? oldO['titleCompany']);
    for (final f in _titleFields) {
      if (_d(_at(nt, f), _at(ot, f))) return true;
    }

    final nParties = _asMap(newO['parties']);
    final oParties = _asMap(oldO['parties']);
    for (final role in ['buyer', 'second_buyer', 'secondBuyer', 'agent']) {
      final nParty = _asMap(nParties[role]);
      final oParty = _asMap(oParties[role]);
      for (final f in _contactFields) {
        if (_d(_at(nParty, f), _at(oParty, f))) return true;
      }
    }

    final na = _asMap(_asMap(newO['property'])['address']);
    final oa = _asMap(_asMap(oldO['property'])['address']);
    for (final f in _addressFields) {
      if (_d(_at(na, f), _at(oa, f))) return true;
    }

    return false;
  }

  List<String> getChangedFields(
      Map<String, dynamic> newO, Map<String, dynamic> oldO) {
    final changed = <String>[];
    final np = _asMap(newO['pricing']);
    final op = _asMap(oldO['pricing']);
    for (final f in _pricingFields) {
      if (_d(_at(np, f), _at(op, f))) changed.add('pricing.$f');
    }

    final nf = _asMap(newO['financials']);
    final of2 = _asMap(oldO['financials']);
    for (final f in _financialFields) {
      if (_d(_at(nf, f), _at(of2, f))) changed.add('financials.$f');
    }

    if (_d(_firstValue(newO, ['closing_date', 'closingDate']),
        _firstValue(oldO, ['closing_date', 'closingDate']))) {
      changed.add('closing_date');
    }
    if (_d(_firstValue(newO, ['closing_days', 'closingDays']),
        _firstValue(oldO, ['closing_days', 'closingDays']))) {
      changed.add('closing_days');
    }

    final nc = _asMap(newO['conditions']);
    final oc = _asMap(oldO['conditions']);
    for (final f in _conditionFields) {
      if (_d(_at(nc, f), _at(oc, f))) changed.add('conditions.$f');
    }

    final nt = _asMap(newO['title_company'] ?? newO['titleCompany']);
    final ot = _asMap(oldO['title_company'] ?? oldO['titleCompany']);
    for (final f in _titleFields) {
      if (_d(_at(nt, f), _at(ot, f))) changed.add('title_company.$f');
    }

    final nParties = _asMap(newO['parties']);
    final oParties = _asMap(oldO['parties']);
    for (final role in ['buyer', 'second_buyer', 'secondBuyer', 'agent']) {
      final nParty = _asMap(nParties[role]);
      final oParty = _asMap(oParties[role]);
      for (final f in _contactFields) {
        if (_d(_at(nParty, f), _at(oParty, f))) {
          changed.add('parties.$role.$f');
        }
      }
    }

    final na = _asMap(_asMap(newO['property'])['address']);
    final oa = _asMap(_asMap(oldO['property'])['address']);
    for (final f in _addressFields) {
      if (_d(_at(na, f), _at(oa, f))) changed.add('address.$f');
    }

    return changed;
  }

  bool _d(dynamic a, dynamic b) {
    if (a == null && b == null) return false;
    return a?.toString() != b?.toString();
  }

  OfferModel _toOfferModel(Map<String, dynamic> raw) {
    return OfferModel.fromJson(_normalizeOffer(raw));
  }

  Map<String, dynamic> _normalizeOffer(Map<String, dynamic> raw) {
    final pricing = _asMap(raw['pricing']);
    final financials = _asMap(raw['financials']);
    final conditions = _asMap(raw['conditions']);
    final parties = _asMap(raw['parties']);
    final titleCompany = _asMap(raw['title_company'] ?? raw['titleCompany']);
    final property = _asMap(raw['property']);

    final buyer = _asMap(parties['buyer']).isNotEmpty
        ? _asMap(parties['buyer'])
        : _asMap(raw['buyer']);
    final seller = _asMap(parties['seller']).isNotEmpty
        ? _asMap(parties['seller'])
        : _asMap(raw['seller']);
    final agent = _asMap(parties['agent']).isNotEmpty
        ? _asMap(parties['agent'])
        : _asMap(raw['agent']);
    final secondBuyer = _asMap(parties['secondBuyer']).isNotEmpty
        ? _asMap(parties['secondBuyer'])
        : _asMap(raw['secondBuyer']);

    final normalized = <String, dynamic>{
      'id': _s(raw['id']) ?? _s(raw['offerID']) ?? '',
      'status': (_s(raw['status']) ?? 'draft').toLowerCase(),
      'createdTime':
          _dt(raw['createdTime'] ?? raw['created_at'])?.toIso8601String(),
      'closingDate':
          _dt(raw['closingDate'] ?? raw['closing_date'])?.toIso8601String(),
      'closingDays': _i(raw['closingDays'] ?? raw['closing_days']),
      'propertyId': _s(raw['propertyId']) ?? _s(raw['property_id']) ?? '',
      'sellerId':
          _s(raw['sellerId']) ?? _s(raw['seller_id']) ?? _s(seller['id']) ?? '',
      'buyerId':
          _s(raw['buyerId']) ?? _s(raw['buyer_id']) ?? _s(buyer['id']) ?? '',
      'chatId': _s(raw['chatId']) ?? _s(raw['chat_id']) ?? '',
      'counteredCount': _i(raw['counteredCount'] ??
          raw['countered_count'] ??
          pricing['countered_count']),
      'listPrice': _s(raw['listPrice']) ??
          _s(raw['list_price']) ??
          _s(pricing['listPrice']) ??
          _s(pricing['list_price']) ??
          '',
      'purchasePrice': _i(raw['purchasePrice'] ??
          raw['purchase_price'] ??
          pricing['purchasePrice'] ??
          pricing['purchase_price']),
      'finalPrice': _s(raw['finalPrice']) ??
          _s(raw['final_price']) ??
          _s(pricing['finalPrice']) ??
          _s(pricing['final_price']) ??
          '',
      'loanType': _s(raw['loanType']) ??
          _s(raw['loan_type']) ??
          _s(financials['loan_type']) ??
          _s(financials['loanType']) ??
          '',
      'downPaymentAmount': _i(raw['downPaymentAmount'] ??
          raw['down_payment_amount'] ??
          financials['downPaymentAmount'] ??
          financials['down_payment_amount']),
      'loanAmount': _i(raw['loanAmount'] ??
          raw['loan_amount'] ??
          financials['loanAmount'] ??
          financials['loan_amount']),
      'requestForSellerCredit': _i(raw['requestForSellerCredit'] ??
          raw['request_for_seller_credit'] ??
          raw['credit_request'] ??
          financials['creditRequest'] ??
          financials['credit_request']),
      'depositType': _s(raw['depositType']) ??
          _s(raw['deposit_type']) ??
          _s(financials['depositType']) ??
          _s(financials['deposit_type']) ??
          '',
      'depositAmount': _i(raw['depositAmount'] ??
          raw['deposit_amount'] ??
          financials['depositAmount'] ??
          financials['deposit_amount']),
      'coverageAmount': _i(raw['coverageAmount'] ??
          raw['coverage_amount'] ??
          financials['coverageAmount'] ??
          financials['coverage_amount']),
      'additionalEarnest': _i(raw['additionalEarnest'] ??
          raw['additional_earnest'] ??
          financials['additionalEarnest'] ??
          financials['additional_earnest']),
      'optionFee': _i(raw['optionFee'] ??
          raw['option_fee'] ??
          financials['optionFee'] ??
          financials['option_fee']),
      'propertyCondition': _s(raw['propertyCondition']) ??
          _s(raw['property_condition']) ??
          _s(conditions['propertyCondition']) ??
          _s(conditions['property_condition']) ??
          '',
      'preApproval': _b(raw['preApproval'] ??
          raw['pre_approval'] ??
          conditions['preApproval'] ??
          conditions['pre_approval']),
      'survey': _b(raw['survey'] ?? conditions['survey']),
      'addendums': raw['addendums'] ?? const [],
      'buyer': {
        'id': _s(buyer['id']) ?? _s(raw['buyer_id']) ?? '',
        'name': _s(buyer['name']) ?? '',
        'phoneNumber':
            _s(buyer['phone_number']) ?? _s(buyer['phoneNumber']) ?? '',
        'email': _s(buyer['email']) ?? '',
      },
      'secondBuyer': {
        'id': _s(secondBuyer['id']) ?? '',
        'name': _s(secondBuyer['name']) ?? '',
        'phoneNumber': _s(secondBuyer['phone_number']) ??
            _s(secondBuyer['phoneNumber']) ??
            '',
        'email': _s(secondBuyer['email']) ?? '',
      },
      'seller': {
        'id': _s(seller['id']) ?? _s(raw['seller_id']) ?? '',
        'name': _s(seller['name']) ?? '',
        'phoneNumber':
            _s(seller['phone_number']) ?? _s(seller['phoneNumber']) ?? '',
        'email': _s(seller['email']) ?? '',
      },
      'agent': {
        'id': _s(agent['id']) ?? _s(raw['agent_id']) ?? '',
        'name': _s(agent['name']) ?? '',
        'phoneNumber':
            _s(agent['phone_number']) ?? _s(agent['phoneNumber']) ?? '',
        'email': _s(agent['email']) ?? '',
      },
      'titleCompany': {
        'id': _s(titleCompany['id']) ?? '',
        'companyName': _s(titleCompany['company_name']) ??
            _s(titleCompany['companyName']) ??
            '',
        'phoneNumber': _s(titleCompany['phone_number']) ??
            _s(titleCompany['phoneNumber']) ??
            '',
        'choice': _s(titleCompany['choice']) ?? '',
        'agent': {
          'id': _s(_asMap(titleCompany['agent'])['id']) ?? '',
          'name': _s(_asMap(titleCompany['agent'])['name']) ?? '',
        },
      },
      'property': _normalizeProperty(property),
    };

    return normalized;
  }

  Map<String, dynamic> _normalizeProperty(Map<String, dynamic> property) {
    final address = _asMap(property['address']);
    final street = [
      _s(address['street_number']) ?? _s(address['streetNumber']),
      _s(address['street_direction']) ?? _s(address['streetDirection']),
      _s(address['street_name']) ?? _s(address['streetName']),
      _s(address['street_type']) ?? _s(address['streetType']),
    ].whereType<String>().where((v) => v.isNotEmpty).join(' ');

    final line =
        street.isNotEmpty ? street : (_s(property['propertyName']) ?? '');

    return {
      'id': _s(property['id']) ?? '',
      'propertyType':
          _s(property['property_type']) ?? _s(property['propertyType']) ?? '',
      'title': line,
      'description': _s(property['description']) ?? _s(property['notes']) ?? '',
      'beds': (_i(property['bedrooms']) > 0)
          ? _i(property['bedrooms']).toString()
          : (_s(property['beds']) ?? ''),
      'baths': (_i(property['bathrooms']) > 0)
          ? _i(property['bathrooms']).toString()
          : (_s(property['baths']) ?? ''),
      'sqft': (_i(property['squareFootage']) > 0)
          ? _i(property['squareFootage']).toString()
          : (_i(property['square_footage']) > 0)
              ? _i(property['square_footage']).toString()
              : (_s(property['sqft']) ?? ''),
      'price': _i(
          property['price'] ?? property['list_price'] ?? property['listPrice']),
      'images': property['images'] ?? property['media'] ?? const [],
      'listDate': _s(property['listDate']) ?? _s(property['list_date']) ?? '',
      'listPrice': _i(property['listPrice'] ?? property['list_price']),
      'location': {
        'city': _s(address['city']) ??
            _s(_asMap(property['location'])['city']) ??
            '',
        'state': _s(address['state']) ??
            _s(_asMap(property['location'])['state']) ??
            '',
        'zipCode': _s(address['zip']) ??
            _s(address['zipCode']) ??
            _s(_asMap(property['location'])['zipCode']) ??
            _s(_asMap(property['location'])['zip_code']) ??
            '',
        'address': line,
      },
    };
  }

  Map<String, dynamic> _asMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return Map<String, dynamic>.from(v);
    try {
      final maybe = (v as dynamic).toJson();
      if (maybe is Map<String, dynamic>) return maybe;
      if (maybe is Map) return Map<String, dynamic>.from(maybe);
    } catch (_) {}
    return <String, dynamic>{};
  }

  String? _s(dynamic v) {
    if (v == null) return null;
    final out = v.toString().trim();
    return out.isEmpty ? null : out;
  }

  int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  bool _b(dynamic v) {
    if (v is bool) return v;
    if (v is String) return v.toLowerCase() == 'true';
    return false;
  }

  DateTime? _dt(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
    if (v is Map) {
      final seconds = v['_seconds'];
      if (seconds is int) {
        return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      }
    }
    try {
      final maybe = (v as dynamic).toDate();
      if (maybe is DateTime) return maybe;
    } catch (_) {}
    return null;
  }

  // -- Revision History Access Methods --

  /// Gets all revisions for an offer
  Future<Either<Failure, List<OfferRevisionModel>>> getOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    return _revisionRepo.getOfferRevisions(offerId: offerId, limit: limit);
  }

  /// Gets a specific revision by ID
  Future<Either<Failure, OfferRevisionModel>> getRevisionById({
    required String offerId,
    required String revisionId,
  }) {
    return _revisionRepo.getRevisionById(
        offerId: offerId, revisionId: revisionId);
  }

  /// Gets revisions made by a specific user
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByUser({
    required String offerId,
    required String userId,
    int? limit,
  }) {
    return _revisionRepo.getRevisionsByUser(
      offerId: offerId,
      userId: userId,
      limit: limit,
    );
  }

  /// Gets revisions of a specific type (e.g., status changes)
  Future<Either<Failure, List<OfferRevisionModel>>> getRevisionsByType({
    required String offerId,
    required OfferRevisionType revisionType,
    int? limit,
  }) {
    return _revisionRepo.getRevisionsByType(
      offerId: offerId,
      revisionType: revisionType,
      limit: limit,
    );
  }

  /// Gets the count of revisions for an offer
  Future<Either<Failure, int>> getRevisionCount({required String offerId}) {
    return _revisionRepo.getRevisionCount(offerId: offerId);
  }

  /// Streams real-time revisions for an offer
  Stream<Either<Failure, List<OfferRevisionModel>>> streamOfferRevisions({
    required String offerId,
    int? limit,
  }) {
    return _revisionRepo.streamOfferRevisions(offerId: offerId, limit: limit);
  }

  /// Gets the latest revision for an offer
  Future<Either<Failure, OfferRevisionModel?>> getLatestRevision({
    required String offerId,
  }) {
    return _revisionRepo.getLatestRevision(offerId: offerId);
  }

  // -- Helper Methods --

  /// Parses status string to Status enum
  /// Handles various formats: 'Pending', 'pending', 'PENDING', etc.
  Status? _parseStatus(dynamic status) {
    if (status == null) return null;
    if (status is Status) return status;

    final statusStr = status.toString().toLowerCase();
    switch (statusStr) {
      case 'draft':
        return Status.Draft;
      case 'pending':
        return Status.Pending;
      case 'accepted':
        return Status.Accepted;
      case 'declined':
        return Status.Declined;
      default:
        return null;
    }
  }

  Future<void> _createNotificationsForChange({
    required Map<String, dynamic>? offerBefore,
    required Map<String, dynamic> offerAfter,
    required String actorUserId,
    required String actorName,
    required bool revisionCreated,
  }) async {
    try {
      final recipients = _extractRecipientUserIds(offerAfter, actorUserId);
      if (recipients.isEmpty) return;

      final offerId =
          offerAfter['offerID'] as String? ?? offerAfter['id'] as String? ?? '';
      if (offerId.isEmpty) return;

      final addressMap = (offerAfter['property'] as Map<String, dynamic>? ??
              {})['address'] as Map<String, dynamic>? ??
          {};
      final propertyAddress = [
        addressMap['street_number'],
        addressMap['street_name'],
        addressMap['city'],
      ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' ');

      final oldStatus = _parseStatus(offerBefore?['status']);
      final newStatus = _parseStatus(offerAfter['status']);
      final statusChanged =
          oldStatus != null && newStatus != null && oldStatus != newStatus;

      for (final userId in recipients) {
        if (statusChanged) {
          final statusName = newStatus.name;
          await _notificationRepo.createNotification(
            recipientUserId: userId,
            notification: OfferNotificationModel(
              recipientUserId: userId,
              actorUserId: actorUserId,
              actorName: actorName,
              type: OfferNotificationType.statusChanged,
              offerId: offerId,
              propertyAddress: propertyAddress,
              title: 'Offer Status Updated',
              message: 'Offer is now $statusName.',
              createdAt: DateTime.now(),
              actionTarget: 'offer/$offerId',
              metadata: {
                'oldStatus': oldStatus.name,
                'newStatus': statusName,
              },
            ),
          );
        }

        if (revisionCreated) {
          await _notificationRepo.createNotification(
            recipientUserId: userId,
            notification: OfferNotificationModel(
              recipientUserId: userId,
              actorUserId: actorUserId,
              actorName: actorName,
              type: OfferNotificationType.revisionCreated,
              offerId: offerId,
              propertyAddress: propertyAddress,
              title: 'Offer Updated',
              message: 'A new revision was added to this offer.',
              createdAt: DateTime.now(),
              actionTarget: 'offer/$offerId',
            ),
          );
        }
      }
    } catch (_) {
      // Notification delivery should not block core offer operations.
    }
  }

  Set<String> _extractRecipientUserIds(
    Map<String, dynamic> offerData,
    String actorUserId,
  ) {
    final parties = _asMap(offerData['parties']);
    final ids = <String>{};

    for (final role in [
      'buyer',
      'seller',
      'agent',
      'second_buyer',
      'secondBuyer'
    ]) {
      final party = _asMap(parties[role]);
      final id = _s(party['id']);
      if (id != null && id.isNotEmpty && id != actorUserId) {
        ids.add(id);
      }
    }
    return ids;
  }
}
