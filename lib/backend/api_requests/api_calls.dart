import '../../core/config/env_config.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start iwo-seller-properties-api Group Code

class IwoSellerPropertiesApiGroup {
  static String getBaseUrl() =>
      'http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static GetPropertiesByZipIdCall getPropertiesByZipIdCall =
      GetPropertiesByZipIdCall();
  static GetAllPropertiesCall getAllPropertiesCall = GetAllPropertiesCall();
  static GetSellerPropertiesCall getSellerPropertiesCall =
      GetSellerPropertiesCall();
  static InsertSellerPropertyCall insertSellerPropertyCall =
      InsertSellerPropertyCall();
  static UpdateSellerPropertyCall updateSellerPropertyCall =
      UpdateSellerPropertyCall();
  static DeleteSellerPropertyCall deleteSellerPropertyCall =
      DeleteSellerPropertyCall();
  static GetAllPropertiesAdminCall getAllPropertiesAdminCall =
      GetAllPropertiesAdminCall();
  static InsertSellerPropertyAdminCall insertSellerPropertyAdminCall =
      InsertSellerPropertyAdminCall();
  static UpdateSellerPropertyAdminCall updateSellerPropertyAdminCall =
      UpdateSellerPropertyAdminCall();
  static DeleteSellerPropertyAdminCall deleteSellerPropertyAdminCall =
      DeleteSellerPropertyAdminCall();
}

class GetPropertiesByZipIdCall {
  Future<ApiCallResponse> call({
    String? zpId = '',
    String? userId = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getPropertiesByZipId',
      apiUrl: '${baseUrl}/properties/${zpId}',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${userId}',
      },
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? propertyData(dynamic response) => getJsonField(
        response,
        r'''$[:].contact_recipients''',
        true,
      ) as List?;
  String? zIPid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  dynamic? address(dynamic response) => getJsonField(
        response,
        r'''$.address''',
      );
  List<String>? media(dynamic response) => (getJsonField(
        response,
        r'''$.media''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  int? bathrooms(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.bathrooms''',
      ));
  int? bedrooms(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.bedrooms''',
      ));
  int? listPrice(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.list_price''',
      ));
  String? countyParishPrecinct(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.county_parish_precinct''',
      ));
  String? lotSize(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lot_size''',
      ));
  String? notes(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.notes''',
      ));
  String? propertyType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.property_type''',
      ));
  String? squareFootage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.square_footage''',
      ));
  int? yearBuilt(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.year_built''',
      ));
  double? latitude(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.latitude''',
      ));
  double? longitude(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.longitude''',
      ));
  String? streetName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.street_name''',
      ));
  String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.city''',
      ));
  String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.state''',
      ));
  String? zip(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.zip''',
      ));
  bool? isSold(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.is_sold''',
      ));
  bool? listPriceReduction(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.list_price_reduction''',
      ));
  bool? listNegotiab(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.list_negotiable''',
      ));
  bool? inContract(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.in_contract''',
      ));
  bool? listAsIs(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.list_as_is''',
      ));
  List? selllerId(dynamic response) => getJsonField(
        response,
        r'''$.seller_id''',
        true,
      ) as List?;
  int? mlsID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.mls_id''',
      ));
  bool? isPending(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.is_pending''',
      ));
}

class GetAllPropertiesCall {
  Future<ApiCallResponse> call({
    String? zip = '',
    String? city = '',
    String? state = '',
    String? user = '',
    String? statusType = '',
    int? isPendingUnderContract,
    String? homeType = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllProperties',
      apiUrl: '${baseUrl}/properties/user',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${user}',
      },
      params: {
        'zip': zip,
        'city': city,
        'state': state,
        'status_type': statusType,
        'isPendingUnderContract': isPendingUnderContract,
        'home_type': homeType,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<double>? latitudes(dynamic response) => (getJsonField(
        response,
        r'''$[:].latitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  List<double>? longitudes(dynamic response) => (getJsonField(
        response,
        r'''$[:].longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
}

class GetSellerPropertiesCall {
  Future<ApiCallResponse> call({
    bool? zillowProperties,
    String? zip = '',
    String? city = '',
    String? state = '',
    String? userId = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSellerProperties',
      apiUrl: '${baseUrl}/properties/seller',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${userId}',
      },
      params: {
        'zillowProperties': zillowProperties,
        'zip': zip,
        'city': city,
        'state': state,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertSellerPropertyCall {
  Future<ApiCallResponse> call({
    String? generated = '',
    dynamic? bodyJson,
    String? userId = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertSellerProperty',
      apiUrl: '${baseUrl}/properties/seller',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${userId}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSellerPropertyCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'updateSellerProperty',
      apiUrl: '${baseUrl}/properties/seller',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteSellerPropertyCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? propertyId = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "id": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'deleteSellerProperty',
      apiUrl: '${baseUrl}/properties/seller',
      callType: ApiCallType.DELETE,
      headers: {
        'requester-id': '${userId}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: true,
    );
  }
}

class GetAllPropertiesAdminCall {
  Future<ApiCallResponse> call({
    String? zillowProperties = '',
    String? zip = '',
    String? city = '',
    String? state = '',
    String? admin = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllPropertiesAdmin',
      apiUrl: '${baseUrl}/properties/admin',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${admin}',
      },
      params: {
        'zillowProperties': zillowProperties,
        'zip': zip,
        'city': city,
        'state': state,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertSellerPropertyAdminCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'insertSellerPropertyAdmin',
      apiUrl: '${baseUrl}/properties/admin',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSellerPropertyAdminCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'updateSellerPropertyAdmin',
      apiUrl: '${baseUrl}/properties/admin',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteSellerPropertyAdminCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoSellerPropertiesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteSellerPropertyAdmin',
      apiUrl: '${baseUrl}/properties/admin',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-seller-properties-api Group Code

/// Start iwo-users-account-api Group Code

class IwoUsersAccountApiGroup {
  static String getBaseUrl() =>
      'http://iwo-users-account-api.us-w2.cloudhub.io/api';
  static Map<String, String> headers = {};
  static FetchsAllThePropertiesListedInTheTableThatAreOfAnyStatusFilteredOnGivenParametersByUserCall
      fetchsAllThePropertiesListedInTheTableThatAreOfAnyStatusFilteredOnGivenParametersByUserCall =
      FetchsAllThePropertiesListedInTheTableThatAreOfAnyStatusFilteredOnGivenParametersByUserCall();
  static InsertUserSingleRecordCall insertUserSingleRecordCall =
      InsertUserSingleRecordCall();
  static ThisMethodIsUsedToMakeUpdatesOnTheExistingRecordOfTheTableInitiatedByUserCall
      thisMethodIsUsedToMakeUpdatesOnTheExistingRecordOfTheTableInitiatedByUserCall =
      ThisMethodIsUsedToMakeUpdatesOnTheExistingRecordOfTheTableInitiatedByUserCall();
  static ThisMethodIsUsedToMakeThePropertyStatusAsInactiveSoTheOtherUsersUnableToSeeThemCall
      thisMethodIsUsedToMakeThePropertyStatusAsInactiveSoTheOtherUsersUnableToSeeThemCall =
      ThisMethodIsUsedToMakeThePropertyStatusAsInactiveSoTheOtherUsersUnableToSeeThemCall();
  static FetchsAllThePropertiesListedInTheTableThatAreActiveAndAvailbleToSellByTheSellerCall
      fetchsAllThePropertiesListedInTheTableThatAreActiveAndAvailbleToSellByTheSellerCall =
      FetchsAllThePropertiesListedInTheTableThatAreActiveAndAvailbleToSellByTheSellerCall();
}

class FetchsAllThePropertiesListedInTheTableThatAreOfAnyStatusFilteredOnGivenParametersByUserCall {
  Future<ApiCallResponse> call({
    String? userName = '',
    String? email = '',
    String? id = '',
  }) async {
    final baseUrl = IwoUsersAccountApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetchs all the properties listed in the table that are of any status filtered on given parameters by user',
      apiUrl: '${baseUrl}/account/user',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_name': userName,
        'email': email,
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertUserSingleRecordCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoUsersAccountApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'insertUserSingleRecord',
      apiUrl: '${baseUrl}/account/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToMakeUpdatesOnTheExistingRecordOfTheTableInitiatedByUserCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoUsersAccountApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to make updates on the existing record of the table initiated by user',
      apiUrl: '${baseUrl}/account/user',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToMakeThePropertyStatusAsInactiveSoTheOtherUsersUnableToSeeThemCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoUsersAccountApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to make the property status as inactive so the other users unable to see them',
      apiUrl: '${baseUrl}/account/user',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchsAllThePropertiesListedInTheTableThatAreActiveAndAvailbleToSellByTheSellerCall {
  Future<ApiCallResponse> call({
    String? userName = '',
    String? email = '',
    String? id = '',
  }) async {
    final baseUrl = IwoUsersAccountApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetchs all the properties listed in the table that are active and availble to sell by the seller',
      apiUrl: '${baseUrl}/account/admin',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_name': userName,
        'email': email,
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-users-account-api Group Code

/// Start iwo-users-favorites-api Group Code

class IwoUsersFavoritesApiGroup {
  static String getBaseUrl() =>
      'http://iwo-users-favorites-api.us-w2.cloudhub.io/api/';
  static Map<String, String> headers = {};
  static GetFavoritePropertiesCall getFavoritePropertiesCall =
      GetFavoritePropertiesCall();
  static InsertSingleFavoritePropertyCall insertSingleFavoritePropertyCall =
      InsertSingleFavoritePropertyCall();
  static UpdateSingleFavoritePropertyCall updateSingleFavoritePropertyCall =
      UpdateSingleFavoritePropertyCall();
  static DeleteSingleFavoritePropertyCall deleteSingleFavoritePropertyCall =
      DeleteSingleFavoritePropertyCall();
  static GetFavoritePropertyCall getFavoritePropertyCall =
      GetFavoritePropertyCall();
}

class GetFavoritePropertiesCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = IwoUsersFavoritesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getFavoriteProperties',
      apiUrl: '${baseUrl}favorites/user',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? notes(dynamic response) => (getJsonField(
        response,
        r'''$[:].notes''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? propertyId(dynamic response) => (getJsonField(
        response,
        r'''$[:].property_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  bool? isDeleted(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].is_deleted_by_user''',
      ));
  List<bool>? status(dynamic response) => (getJsonField(
        response,
        r'''$[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? createdby(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? userID(dynamic response) => (getJsonField(
        response,
        r'''$[:].user_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdat(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? updatedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].last_updated_date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? favID(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class InsertSingleFavoritePropertyCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
    String? createdBy = '',
    String? note = '',
  }) async {
    final baseUrl = IwoUsersFavoritesApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "status": true,
  "created_by": "${createdBy}",
  "property_id": "${propertyId}",
  "user_id": "${userId}",
  "notes": "${note}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertSingleFavoriteProperty',
      apiUrl: '${baseUrl}favorites/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSingleFavoritePropertyCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
    String? createdBy = '',
    String? note = '',
  }) async {
    final baseUrl = IwoUsersFavoritesApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "status": true,
  "property_id": "${propertyId}",
  "user_id": "${userId}",
  "created_by": "${createdBy}",
  "notes": "${note}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateSingleFavoriteProperty',
      apiUrl: '${baseUrl}favorites/user',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteSingleFavoritePropertyCall {
  Future<ApiCallResponse> call({
    String? generated = '',
    String? userId = '',
    String? propertyId = '',
  }) async {
    final baseUrl = IwoUsersFavoritesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteSingleFavoriteProperty',
      apiUrl: '${baseUrl}favorites/user',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {
        'user_id': userId,
        'property_id': propertyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetFavoritePropertyCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? propertyId,
  }) async {
    propertyId ??= null!;
    final baseUrl = IwoUsersFavoritesApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getFavoriteProperty',
      apiUrl: '${baseUrl}favorites/user',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_id': userId,
        'property_id': propertyId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-users-favorites-api Group Code

/// Start iwoAccount Group Code

class IwoAccountGroup {
  static String getBaseUrl() =>
      'http://iwo-users-account-api.us-w2.cloudhub.io/api/account';
  static Map<String, String> headers = {};
  static AddUserCall addUserCall = AddUserCall();
  static UpdateUserCall updateUserCall = UpdateUserCall();
  static DeleteUserCall deleteUserCall = DeleteUserCall();
  static GetUserCall getUserCall = GetUserCall();
}

class AddUserCall {
  Future<ApiCallResponse> call({
    dynamic? bodyJson,
  }) async {
    final baseUrl = IwoAccountGroup.getBaseUrl();

    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addUser',
      apiUrl: '${baseUrl}/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserCall {
  Future<ApiCallResponse> call({
    dynamic? bodyJson,
  }) async {
    final baseUrl = IwoAccountGroup.getBaseUrl();

    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUser',
      apiUrl: '${baseUrl}/user',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteUserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = IwoAccountGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteUser',
      apiUrl: '${baseUrl}/user',
      callType: ApiCallType.DELETE,
      headers: {
        'requester-id': '${userId}',
      },
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = IwoAccountGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getUser',
      apiUrl: '${baseUrl}/user',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwoAccount Group Code

/// Start iwo-users-saved-search-api Group Code

class IwoUsersSavedSearchApiGroup {
  static String getBaseUrl() =>
      'http://iwo-users-saved-search-api.us-w2.cloudhub.io/api/';
  static Map<String, String> headers = {};
  static GetSavedSearchesCall getSavedSearchesCall = GetSavedSearchesCall();
  static InsertSavedSearchCall insertSavedSearchCall = InsertSavedSearchCall();
  static UpdateSavedSearchCall updateSavedSearchCall = UpdateSavedSearchCall();
  static DeleteSavedSearchCall deleteSavedSearchCall = DeleteSavedSearchCall();
}

class GetSavedSearchesCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? id = '',
  }) async {
    final baseUrl = IwoUsersSavedSearchApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSavedSearches',
      apiUrl: '${baseUrl}saved-search/user',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? propertyId(dynamic response) => (getJsonField(
        response,
        r'''$[:].search.property_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? savedProperties(dynamic response) => getJsonField(
        response,
        r'''$[:].search.property''',
        true,
      ) as List?;
}

class InsertSavedSearchCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? inputField = '',
    bool? status = true,
    dynamic? propertyJson,
  }) async {
    final baseUrl = IwoUsersSavedSearchApiGroup.getBaseUrl();

    final property = _serializeJson(propertyJson);
    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "status": ${status},
  "search": {
    "input_field": "${inputField}",
    "property": ${property}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertSavedSearch',
      apiUrl: '${baseUrl}saved-search/user',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSavedSearchCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoUsersSavedSearchApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'updateSavedSearch',
      apiUrl: '${baseUrl}saved-search/user',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteSavedSearchCall {
  Future<ApiCallResponse> call({
    String? generated = '',
  }) async {
    final baseUrl = IwoUsersSavedSearchApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteSavedSearch',
      apiUrl: '${baseUrl}saved-search/user',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-users-saved-search-api Group Code

/// Start iwo-users-showproperty-api Group Code

class IwoUsersShowpropertyApiGroup {
  static String getBaseUrl() =>
      'http://iwo-users-showproperty-api.us-w2.cloudhub.io/api/';
  static Map<String, String> headers = {};
  static GetShowPropertiesCall getShowPropertiesCall = GetShowPropertiesCall();
  static InsertShowPropertyCall insertShowPropertyCall =
      InsertShowPropertyCall();
  static DeleteShowPropertyCall deleteShowPropertyCall =
      DeleteShowPropertyCall();
}

class GetShowPropertiesCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final baseUrl = IwoUsersShowpropertyApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getShowProperties',
      apiUrl: '${baseUrl}user/showproperty',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertShowPropertyCall {
  Future<ApiCallResponse> call({
    String? userName = '',
    String? userId = '',
    String? phone = '5554441111',
    int? buyerType = 0,
    int? showingType = 0,
    int? price = 50,
    String? notes =
        'Private Showing notes visible to the accepting Showing Agent',
    String? publicNotes = 'Public Showing notes visible to all users',
    bool? narBuyerAgreement = true,
    String? preferredAgent1Emai = 'mrtonyshelton@hotmail.com',
    String? accessInformation =
        'How to access the property (Open House, Inspection, Appraisals only)',
    String? timeZone = 'Mountain Time (US & Canada)',
    String? showingDate = '',
    int? metBuyer = 0,
    int? duration = 0,
    String? mls = '',
    String? line1 = '',
    String? line2 = '',
    String? city = '',
    String? state = '',
    String? zip = '',
    int? whoSchedules = 0,
    String? externalId = '',
    String? scheduleDetails = 'Schedule Details',
  }) async {
    final baseUrl = IwoUsersShowpropertyApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "showing_request": {
    "showing_type": ${showingType},
    "user_name": "${userName}",
    "user_id": "${userId}",
    "phone": "${phone}",
    "buyer_type": ${buyerType},
    "met_buyer": ${metBuyer},
    "price": ${price},
    "notes": "${notes}",
    "public_notes": "${publicNotes}",
    "nar_buyer_agreement": ${narBuyerAgreement},
    "preferred_agent_1_email": "${preferredAgent1Emai}",
    "access_information": "${accessInformation}",
    "time_zone": "${timeZone}",
    "showing_request_properties_attributes": {
      "showing_date": "${showingDate}",
      "duration": ${duration},
      "mls": "${mls}",
      "line1": "${line1}",
      "line2": "${line2}",
      "city": "${city}",
      "state": "${state}",
      "zip": "${zip}",
      "who_schedules": ${whoSchedules},
      "schedule_details": "${scheduleDetails}",
      "external_id": "${externalId}"
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertShowProperty',
      apiUrl: '${baseUrl}user/showproperty',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': '\tapplication/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cause.errorMessage.payload.message''',
      ));
}

class DeleteShowPropertyCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? showingId = '',
  }) async {
    final baseUrl = IwoUsersShowpropertyApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deleteShowProperty',
      apiUrl: '${baseUrl}user/showproperty',
      callType: ApiCallType.DELETE,
      headers: {},
      params: {
        'user_id': userId,
        'showing_id': showingId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-users-showproperty-api Group Code

/// Start iwo-offers-api Group Code

class IwoOffersApiGroup {
  static String getBaseUrl() =>
      'https://dev-iwo-offers-api-wdu99i.goajj2-2.usa-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static GetAscOffersCall getAscOffersCall = GetAscOffersCall();
  static InsertOfferSingleRecordCall insertOfferSingleRecordCall =
      InsertOfferSingleRecordCall();
  static ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheSellerInAscendingOrderCall
      thisMethodIsUsedToFetchAllTheEnteriesMadeByTheSellerInAscendingOrderCall =
      ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheSellerInAscendingOrderCall();
  static ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedBySellerCall
      thisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedBySellerCall =
      ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedBySellerCall();
  static ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheAdminInAscendingOrderCall
      thisMethodIsUsedToFetchAllTheEnteriesMadeByTheAdminInAscendingOrderCall =
      ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheAdminInAscendingOrderCall();
  static ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedByAdminCall
      thisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedByAdminCall =
      ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedByAdminCall();
}

class GetAscOffersCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? offerName = '',
    String? buyer = '',
    String? seller = '',
    String? listPrice = '',
    String? offerPrice = '',
    String? finalPrice = '',
    String? offerAccepted = '',
    String? offerDeclined = '',
    String? status = '',
    String? disclosures = '',
    String? addendums = '',
    String? acceptedOtherOffer = '',
    String? requesterId = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAscOffers',
      apiUrl: '${baseUrl}/offers/user',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {
        'property_id': propertyId,
        'offer_name': offerName,
        'buyer': buyer,
        'seller': seller,
        'list_price': listPrice,
        'offer_price': offerPrice,
        'final_price': finalPrice,
        'offer_accepted': offerAccepted,
        'offer_declined': offerDeclined,
        'status': status,
        'disclosures': disclosures,
        'addendums': addendums,
        'accepted_other_offer': acceptedOtherOffer,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertOfferSingleRecordCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "property_id": "7890101",
  "status": "Pending",
  "created_time": "2025-01-27T12:00:00Z",
  "closing_date": "2025-02-15T12:00:00Z",
  "chat_id": "chat789",
  "pricing": {
    "list_price": 310000,
    "purchase_price": 300000,
    "final_price": 290000,
    "countered_count": 1
  },
  "parties": {
    "seller": {
      "id": "seller123",
      "phone_number": "555-555-555",
      "email": "seller@gmail.com"
    },
    "buyer": {
      "id": "buyer456",
      "name": "Buyer Name",
      "phone_number": "555-555-555",
      "email": "buyer@gmail.com"
    },
    "second_buyer": {
      "id": "buyer789",
      "name": "Second Buyer Name",
      "phone_number": "555-555-555",
      "email": "buyer@gmail.com"
    }
  },
  "financials": {
    "loan_type": "Conventional",
    "down_payment_amount": 60000,
    "loan_amount": 240000,
    "credit_request": 5000,
    "deposit_type": "Cash",
    "deposit_amount": 10000,
    "additional_earnest": 30000,
    "option_fee": 50000
  },
  "conditions": {
    "inspection_condition_status": "Accepted",
    "request_for_repairs_status": "Pending",
    "home_warranty": "Included",
    "pre_approval": true,
    "survey": true,
    "coverage_amount": 6000
  },
  "title_company": {
    "id": "title123",
    "company_name": "Title Company Inc.",
    "phone_number": "123-456-7890",
    "agent": {
      "id": "agent123",
      "name": "Agent Name"
    }
  },
  "addendums": [
    {
      "id": "addendum1",
      "name": "Addendum Name",
      "description": "description",
      "seller_sign": "seller.png",
      "buyer_sign": "buyer.png",
      "document_id": "8432947"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertOfferSingleRecord',
      apiUrl: '${baseUrl}/offers/user',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? offerID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? createdDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.created_at''',
      ));
  String? userID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.created_by''',
      ));
}

class ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheSellerInAscendingOrderCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? offerName = '',
    String? buyer = '',
    String? seller = '',
    String? listPrice = '',
    String? offerPrice = '',
    String? finalPrice = '',
    String? offerAccepted = '',
    String? offerDeclined = '',
    String? status = '',
    String? disclosures = '',
    String? addendums = '',
    String? acceptedOtherOffer = '',
    String? requesterId = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to fetch all the enteries made by the seller in ascending order.',
      apiUrl: '${baseUrl}/offers/seller',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {
        'property_id': propertyId,
        'offer_name': offerName,
        'buyer': buyer,
        'seller': seller,
        'list_price': listPrice,
        'offer_price': offerPrice,
        'final_price': finalPrice,
        'offer_accepted': offerAccepted,
        'offer_declined': offerDeclined,
        'status': status,
        'disclosures': disclosures,
        'addendums': addendums,
        'accepted_other_offer': acceptedOtherOffer,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedBySellerCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to insert a single record into the object, intiated by seller',
      apiUrl: '${baseUrl}/offers/seller',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToFetchAllTheEnteriesMadeByTheAdminInAscendingOrderCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? offerName = '',
    String? buyer = '',
    String? seller = '',
    String? listPrice = '',
    String? offerPrice = '',
    String? finalPrice = '',
    String? offerAccepted = '',
    String? offerDeclined = '',
    String? status = '',
    String? disclosures = '',
    String? addendums = '',
    String? acceptedOtherOffer = '',
    String? requesterId = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to fetch all the enteries made by the admin in ascending order.',
      apiUrl: '${baseUrl}/offers/admin',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {
        'property_id': propertyId,
        'offer_name': offerName,
        'buyer': buyer,
        'seller': seller,
        'list_price': listPrice,
        'offer_price': offerPrice,
        'final_price': finalPrice,
        'offer_accepted': offerAccepted,
        'offer_declined': offerDeclined,
        'status': status,
        'disclosures': disclosures,
        'addendums': addendums,
        'accepted_other_offer': acceptedOtherOffer,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToInsertASingleRecordIntoTheObjectIntiatedByAdminCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoOffersApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to insert a single record into the object, intiated by admin',
      apiUrl: '${baseUrl}/offers/admin',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-offers-api Group Code

/// Start iwo-documents-api Group Code

class IwoDocumentsApiGroup {
  static String getBaseUrl() =>
      'https://dev-iwo-documents-api.us-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static GetDocumentsCall getDocumentsCall = GetDocumentsCall();
  static GetDocumentsByUserCall getDocumentsByUserCall =
      GetDocumentsByUserCall();
  static PostDocumentsByUserCall postDocumentsByUserCall =
      PostDocumentsByUserCall();
  static ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByUserCall
      thisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByUserCall =
      ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByUserCall();
  static FetchListOfEntriesFromDocumentsCollectionWhereTheUserIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall
      fetchListOfEntriesFromDocumentsCollectionWhereTheUserIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall =
      FetchListOfEntriesFromDocumentsCollectionWhereTheUserIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall();
  static FetchAnEntryFromDocumentsCollectionWhereTheUserIdrequesterIdAndPropertyIdIsGivenUriParamCall
      fetchAnEntryFromDocumentsCollectionWhereTheUserIdrequesterIdAndPropertyIdIsGivenUriParamCall =
      FetchAnEntryFromDocumentsCollectionWhereTheUserIdrequesterIdAndPropertyIdIsGivenUriParamCall();
  static ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheSellerInAscendingOrderFilteredByPropertyIdCall
      thisMethodIsUsedToFetchAllTheEnteriesInvolvingTheSellerInAscendingOrderFilteredByPropertyIdCall =
      ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheSellerInAscendingOrderFilteredByPropertyIdCall();
  static ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall
      thisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall =
      ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall();
  static ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall
      thisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall =
      ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall();
  static FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall
      fetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall =
      FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall();
  static FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall
      fetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall =
      FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall();
  static FetchAnEntryFromDocumentsCollectionWithTheDocumentIdWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall
      fetchAnEntryFromDocumentsCollectionWithTheDocumentIdWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall =
      FetchAnEntryFromDocumentsCollectionWithTheDocumentIdWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall();
  static ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheAdminInAscendingOrderFilteredByPropertyIdCall
      thisMethodIsUsedToFetchAllTheEnteriesInvolvingTheAdminInAscendingOrderFilteredByPropertyIdCall =
      ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheAdminInAscendingOrderFilteredByPropertyIdCall();
  static ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall
      thisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall =
      ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall();
  static ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall
      thisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall =
      ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall();
  static FetchAListOfEnteriesFromDocumentsCollectionForTheGivenPropertyIdCall
      fetchAListOfEnteriesFromDocumentsCollectionForTheGivenPropertyIdCall =
      FetchAListOfEnteriesFromDocumentsCollectionForTheGivenPropertyIdCall();
  static FetchAListOfEnteriesFromDocumentsCollectionForTheGivenUserIdAndPropertyIdCall
      fetchAListOfEnteriesFromDocumentsCollectionForTheGivenUserIdAndPropertyIdCall =
      FetchAListOfEnteriesFromDocumentsCollectionForTheGivenUserIdAndPropertyIdCall();
  static FetchAnEntryFromDocumentsCollectionWithTheDocumentIdForTheGivePropertyAndUserCall
      fetchAnEntryFromDocumentsCollectionWithTheDocumentIdForTheGivePropertyAndUserCall =
      FetchAnEntryFromDocumentsCollectionWithTheDocumentIdForTheGivePropertyAndUserCall();
}

class GetDocumentsCall {
  Future<ApiCallResponse> call({
    String? documentId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getDocuments',
      apiUrl: '${baseUrl}/documents/${documentId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDocumentsByUserCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getDocumentsByUser',
      apiUrl: '${baseUrl}/documents/user',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? docFiles(dynamic response) => (getJsonField(
        response,
        r'''$[:].document_file''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PostDocumentsByUserCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? propertyId = '',
    String? documentDirectory = '',
    String? documentFile = '',
    String? documentName = '',
    String? documentType = '',
    String? sellerId = '',
    String? documentSize = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(requesterId)}",
  "property_id": "${escapeStringForJson(propertyId)}",
  "document_directory": "${escapeStringForJson(documentDirectory)}",
  "document_file": "${escapeStringForJson(documentFile)}",
  "document_type": "${escapeStringForJson(documentType)}",
  "document_name": "${escapeStringForJson(documentName)}",
  "document_size": "${escapeStringForJson(documentSize)}",
  "seller_id": "${escapeStringForJson(sellerId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postDocumentsByUser',
      apiUrl: '${baseUrl}/documents/user',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByUserCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to update a single record into the documents collection, intiated by user',
      apiUrl: '${baseUrl}/documents/user',
      callType: ApiCallType.PATCH,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchListOfEntriesFromDocumentsCollectionWhereTheUserIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch list of entries from documents collection where the user_id equals to the requester id and property_id=given id.',
      apiUrl: '${baseUrl}/documents/user/${propertyId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchAnEntryFromDocumentsCollectionWhereTheUserIdrequesterIdAndPropertyIdIsGivenUriParamCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? documentId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch an entry from documents collection where the user_id=requester_id and property_id is given uri param',
      apiUrl: '${baseUrl}/documents/user/${propertyId}/${documentId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheSellerInAscendingOrderFilteredByPropertyIdCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to fetch all the enteries involving the seller in ascending order filtered by property id.',
      apiUrl: '${baseUrl}/documents/seller',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to insert a single record into the documents collection, intiated by seller',
      apiUrl: '${baseUrl}/documents/seller',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedBySellerCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to update a single record into the documents collection, intiated by seller',
      apiUrl: '${baseUrl}/documents/seller',
      callType: ApiCallType.PATCH,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdAndPropertyIdgivenIdCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch list of entries from documents collection where the seller_id equals to the requester_id and property_id=given id.',
      apiUrl: '${baseUrl}/documents/seller/${propertyId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchListOfEntriesFromDocumentsCollectionWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch list of entries from documents collection where the seller_id equals to the requester_id, property_id first uri param and user_id is the second one.',
      apiUrl: '${baseUrl}/documents/seller/${propertyId}/${userId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchAnEntryFromDocumentsCollectionWithTheDocumentIdWhereTheSellerIdEqualsToTheRequesterIdPropertyIdFirstUriParamAndUserIdIsTheSecondOneCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
    String? documentId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch an entry from documents collection with the documentId where the seller_id equals to the requester_id, property_id first uri param and user_id is the second one.',
      apiUrl:
          '${baseUrl}/documents/seller/${propertyId}/${userId}/${documentId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToFetchAllTheEnteriesInvolvingTheAdminInAscendingOrderFilteredByPropertyIdCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to fetch all the enteries involving the admin in ascending order filtered by property id.',
      apiUrl: '${baseUrl}/documents/admin',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToInsertASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to insert a single record into the documents collection, intiated by admin',
      apiUrl: '${baseUrl}/documents/admin',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ThisMethodIsUsedToUpdateASingleRecordIntoTheDocumentsCollectionIntiatedByAdminCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    String? generated = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'This method is used to update a single record into the documents collection, intiated by admin',
      apiUrl: '${baseUrl}/documents/admin',
      callType: ApiCallType.PATCH,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchAListOfEnteriesFromDocumentsCollectionForTheGivenPropertyIdCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch a list of enteries from documents collection for the given propertyId',
      apiUrl: '${baseUrl}/documents/admin/${propertyId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchAListOfEnteriesFromDocumentsCollectionForTheGivenUserIdAndPropertyIdCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch a list of enteries from documents collection for the given userId and propertyId',
      apiUrl: '${baseUrl}/documents/admin/${propertyId}/${userId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FetchAnEntryFromDocumentsCollectionWithTheDocumentIdForTheGivePropertyAndUserCall {
  Future<ApiCallResponse> call({
    String? propertyId = '',
    String? userId = '',
    String? documentId = '',
  }) async {
    final baseUrl = IwoDocumentsApiGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName:
          'Fetch an entry from documents collection with the documentId for the give property and user',
      apiUrl:
          '${baseUrl}/documents/admin/${propertyId}/${userId}/${documentId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwo-documents-api Group Code

/// Start DocuSeal API Group Code

class DocuSealAPIGroup {
  static String getBaseUrl() => 'https://api.docuseal.com';
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'X-Auth-Token': EnvConfig.docuSealToken,
  };
  static GetTemplatesCall getTemplatesCall = GetTemplatesCall();
  static GetTemplateCall getTemplateCall = GetTemplateCall();
  static UpdateTemplateCall updateTemplateCall = UpdateTemplateCall();
  static ArchiveTemplateCall archiveTemplateCall = ArchiveTemplateCall();
  static GetSubmissionsCall getSubmissionsCall = GetSubmissionsCall();
  static CreateSubmissionCall createSubmissionCall = CreateSubmissionCall();
  static GetSubmissionCall getSubmissionCall = GetSubmissionCall();
  static ArchiveSubmissionCall archiveSubmissionCall = ArchiveSubmissionCall();
  static CreateSubmissionsFromEmailsCall createSubmissionsFromEmailsCall =
      CreateSubmissionsFromEmailsCall();
  static GetSubmitterCall getSubmitterCall = GetSubmitterCall();
  static UpdateSubmitterCall updateSubmitterCall = UpdateSubmitterCall();
  static GetSubmittersCall getSubmittersCall = GetSubmittersCall();
  static AddDocumentToTemplateCall addDocumentToTemplateCall =
      AddDocumentToTemplateCall();
  static CloneTemplateCall cloneTemplateCall = CloneTemplateCall();
  static CreateTemplateFromHtmlCall createTemplateFromHtmlCall =
      CreateTemplateFromHtmlCall();
  static CreateTemplateFromDocxCall createTemplateFromDocxCall =
      CreateTemplateFromDocxCall();
  static CreateTemplateFromPdfCall createTemplateFromPdfCall =
      CreateTemplateFromPdfCall();
  static MergeTemplateCall mergeTemplateCall = MergeTemplateCall();
}

class GetTemplatesCall {
  Future<ApiCallResponse> call({
    String? q = '',
    String? externalId = '',
    String? folder = '',
    bool? archived,
    int? limit,
    int? after,
    int? before,
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getTemplates',
      apiUrl: '${baseUrl}/templates',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTemplateCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getTemplate',
      apiUrl: '${baseUrl}/templates/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTemplateCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "New Document Name",
  "folder_name": "New Folder",
  "roles": [
    ""
  ],
  "archived": false
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateTemplate',
      apiUrl: '${baseUrl}/templates/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ArchiveTemplateCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'archiveTemplate',
      apiUrl: '${baseUrl}/templates/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSubmissionsCall {
  Future<ApiCallResponse> call({
    int? templateId,
    String? status = '',
    String? q = '',
    String? templateFolder = '',
    int? limit,
    int? after,
    int? before,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSubmissions',
      apiUrl: '${baseUrl}/submissions',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {
        'template_id': templateId,
        'status': status,
        'q': q,
        'template_folder': templateFolder,
        'limit': limit,
        'after': after,
        'before': before,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateSubmissionCall {
  Future<ApiCallResponse> call({
    String? buyerName = '',
    String? buyerDate = '',
    bool? buyerCheck,
    String? secondBuyerName = '',
    String? sellerName = '',
    String? sellerCheck = '',
    String? sellerDate = '',
    String? agentLicence = '',
    String? agentName = '',
    String? propertyAddress = '',
    String? propertyCity = '',
    String? propertyCounty = '',
    String? propertyZip = '',
    String? purchasePrice = '',
    String? offerExpiration = '',
    String? initialDepositPercent = '',
    String? initialDepositAmount = '',
    String? loanAmountPercent = '',
    String? loanAmount = '',
    bool? isFha,
    bool? isVa,
    bool? isSellerFinancing,
    bool? isOther,
    String? downPayment = '',
    String? propertyState = '',
    int? templateId,
    bool? sendEmail,
    String? order = '',
    String? sellerEmail = '',
    String? buyerEmail = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "template_id": ${templateId},
  "send_email": ${sendEmail},
  "order": "${escapeStringForJson(order)}",
  "submitters": [
    {
      "role": "Buyer",
      "email": "${escapeStringForJson(buyerEmail)}",
      "fields": [
        {
          "name": "buyer_name",
          "default_value": "${escapeStringForJson(buyerName)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "buyer_date",
          "default_value": "${escapeStringForJson(buyerDate)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "buyer_check",
          "default_value": "${buyerCheck}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "second_buyer_name",
          "default_value": "${escapeStringForJson(secondBuyerName)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        }
      ]
    },
    {
      "role": "Seller",
      "email": "${escapeStringForJson(sellerEmail)}",
      "fields": [
        {
          "name": "seller_name",
          "default_value": "${escapeStringForJson(sellerName)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "seller_check",
          "default_value": "${escapeStringForJson(sellerCheck)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "seller_date",
          "default_value": "${escapeStringForJson(sellerDate)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        }
      ]
    },
    {
      "role": "Iwo",
      "name": "Iwo",
      "fields": [
        {
          "name": "agent_licence",
          "default_value": "${escapeStringForJson(agentLicence)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "agent_name",
          "default_value": "${escapeStringForJson(agentName)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "property_address",
          "default_value": "${escapeStringForJson(propertyAddress)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "property_city",
          "default_value": "${escapeStringForJson(propertyCity)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "property_county",
          "default_value": "${escapeStringForJson(propertyCounty)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "property_zip",
          "default_value": "${escapeStringForJson(propertyZip)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "purchase_price",
          "default_value": "${escapeStringForJson(purchasePrice)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "offer_expiration",
          "default_value": "${escapeStringForJson(offerExpiration)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "initial_deposit_percent",
          "default_value": "${escapeStringForJson(initialDepositPercent)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "initial_deposit_amount",
          "default_value": "${escapeStringForJson(initialDepositAmount)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "loan_amount_percent",
          "default_value": "${escapeStringForJson(loanAmountPercent)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "loan_amount",
          "default_value": "${escapeStringForJson(loanAmount)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "is_fha",
          "default_value": "${isFha}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "is_va",
          "default_value": "${isVa}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "is_seller_financing",
          "default_value": "${isSellerFinancing}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "is_other",
          "default_value": "${isOther}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "down_payment",
          "default_value": "${escapeStringForJson(downPayment)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        },
        {
          "name": "property_state",
          "default_value": "${escapeStringForJson(propertyState)}",
          "readonly": true,
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "blue",
            "align": "center"
          }
        }
      ]
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createSubmission',
      apiUrl: '${baseUrl}/submissions',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? srcUrl(dynamic response) => (getJsonField(
        response,
        r'''$[:].embed_src''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetSubmissionCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSubmission',
      apiUrl: '${baseUrl}/submissions/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ArchiveSubmissionCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'archiveSubmission',
      apiUrl: '${baseUrl}/submissions/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateSubmissionsFromEmailsCall {
  Future<ApiCallResponse> call({
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "template_id": 1000001,
  "emails": "{{emails}}",
  "send_email": false,
  "message": {
    "subject": "",
    "body": ""
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createSubmissionsFromEmails',
      apiUrl: '${baseUrl}/submissions/emails',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSubmitterCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSubmitter',
      apiUrl: '${baseUrl}/submitters/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateSubmitterCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "",
  "email": "john.doe@example.com",
  "phone": "+1234567890",
  "values": {},
  "external_id": "",
  "send_email": false,
  "send_sms": false,
  "reply_to": "",
  "completed_redirect_url": "",
  "completed": false,
  "message": {
    "subject": "",
    "body": ""
  },
  "fields": [
    {
      "name": "First Name",
      "default_value": "Acme",
      "readonly": false,
      "validation_pattern": "[A-Z]{4}",
      "invalid_message": ""
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateSubmitter',
      apiUrl: '${baseUrl}/submitters/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSubmittersCall {
  Future<ApiCallResponse> call({
    int? submissionId,
    String? q = '',
    String? completedAfter = '',
    String? completedBefore = '',
    String? externalId = '',
    int? limit,
    int? after,
    int? before,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSubmitters',
      apiUrl: '${baseUrl}/submitters',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {
        'submission_id': submissionId,
        'q': q,
        'completed_after': completedAfter,
        'completed_before': completedBefore,
        'external_id': externalId,
        'limit': limit,
        'after': after,
        'before': before,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddDocumentToTemplateCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "documents": [
    {
      "name": "Test Template",
      "file": "",
      "html": "",
      "position": 0,
      "replace": false,
      "remove": false
    }
  ],
  "merge": false
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addDocumentToTemplate',
      apiUrl: '${baseUrl}/templates/${id}/documents',
      callType: ApiCallType.PUT,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CloneTemplateCall {
  Future<ApiCallResponse> call({
    int? id,
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "Cloned Template",
  "folder_name": "",
  "external_id": ""
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'cloneTemplate',
      apiUrl: '${baseUrl}/templates/${id}/clone',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateTemplateFromHtmlCall {
  Future<ApiCallResponse> call({
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "html": "<p>Lorem Ipsum is simply dummy text of the\\n<text-field\\n  name=\\"Industry\\"\\n  role=\\"First Party\\"\\n  required=\\"false\\"\\n  style=\\"width: 80px; height: 16px; display: inline-block; margin-bottom: -4px\\">\\n</text-field>\\nand typesetting industry</p>\\n",
  "html_header": "",
  "html_footer": "",
  "name": "Test Template",
  "size": "A4",
  "external_id": "714d974e-83d8-11ee-b962-0242ac120002",
  "folder_name": "",
  "documents": [
    {
      "html": "<p>Lorem Ipsum is simply dummy text of the\\n<text-field\\n  name=\\"Industry\\"\\n  role=\\"First Party\\"\\n  required=\\"false\\"\\n  style=\\"width: 80px; height: 16px; display: inline-block; margin-bottom: -4px\\">\\n</text-field>\\nand typesetting industry</p>\\n",
      "name": "Test Document"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createTemplateFromHtml',
      apiUrl: '${baseUrl}/templates/html',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateTemplateFromDocxCall {
  Future<ApiCallResponse> call({
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "Test DOCX",
  "external_id": "unique-key",
  "folder_name": "",
  "documents": [
    {
      "name": "",
      "file": "base64",
      "fields": [
        {
          "name": "",
          "role": "",
          "type": "text",
          "areas": [
            {
              "x": 0,
              "y": 0,
              "w": 0,
              "h": 0,
              "page": 0,
              "option": ""
            }
          ],
          "options": [
            ""
          ],
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "black",
            "align": "left",
            "format": "DD/MM/YYYY",
            "price": 99.99,
            "currency": "USD"
          }
        }
      ]
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createTemplateFromDocx',
      apiUrl: '${baseUrl}/templates/docx',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateTemplateFromPdfCall {
  Future<ApiCallResponse> call({
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "Test PDF",
  "folder_name": "",
  "external_id": "unique-key",
  "documents": [
    {
      "name": "",
      "file": "base64",
      "fields": [
        {
          "name": "",
          "role": "",
          "type": "text",
          "areas": [
            {
              "x": 0,
              "y": 0,
              "w": 0,
              "h": 0,
              "page": 1,
              "option": ""
            }
          ],
          "options": [
            ""
          ],
          "preferences": {
            "font_size": 12,
            "font": "Times",
            "color": "black",
            "align": "left",
            "format": "DD/MM/YYYY",
            "price": 99.99,
            "currency": "USD"
          }
        }
      ],
      "flatten": false,
      "remove_tags": false
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createTemplateFromPdf',
      apiUrl: '${baseUrl}/templates/pdf',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MergeTemplateCall {
  Future<ApiCallResponse> call({
    String? xAuthToken = '',
  }) async {
    final baseUrl = DocuSealAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "template_ids": [
    0
  ],
  "name": "Merged Template",
  "folder_name": "",
  "external_id": ""
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mergeTemplate',
      apiUrl: '${baseUrl}/templates/merge',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'X-Auth-Token': EnvConfig.docuSealToken,
        'X-Auth-Token': '${xAuthToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End DocuSeal API Group Code

/// Start iwoOffers Group Code

class IwoOffersGroup {
  static String getBaseUrl() =>
      'https://dev-iwo-offers-cors.us-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static GetAllOffersCall getAllOffersCall = GetAllOffersCall();
  static GetOfferByIdCall getOfferByIdCall = GetOfferByIdCall();
  static InsertOfferCall insertOfferCall = InsertOfferCall();
  static GetOfferByRequesterIdCall getOfferByRequesterIdCall =
      GetOfferByRequesterIdCall();
}

class GetAllOffersCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = IwoOffersGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllOffers',
      apiUrl: '${baseUrl}/offers',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOfferByIdCall {
  Future<ApiCallResponse> call({
    String? id = '',
  }) async {
    final baseUrl = IwoOffersGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getOfferById',
      apiUrl: '${baseUrl}/offers/${id}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertOfferCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = IwoOffersGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insertOffer',
      apiUrl: '${baseUrl}/offers',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
        'requester-id': '${requesterId}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOfferByRequesterIdCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
  }) async {
    final baseUrl = IwoOffersGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getOfferByRequesterId',
      apiUrl: '${baseUrl}/offers',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'requester-id': requesterId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwoOffers Group Code

/// Start iwoPatches API Group Code

class IwoPatchesAPIGroup {
  static String getBaseUrl() =>
      'https://dev-iwo-transactions.us-w2.cloudhub.io/api/v1/patch';
  static Map<String, String> headers = {};
  static UpdateOfferByIdCall updateOfferByIdCall = UpdateOfferByIdCall();
}

class UpdateOfferByIdCall {
  Future<ApiCallResponse> call({
    String? id = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = IwoPatchesAPIGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateOfferById',
      apiUrl: '${baseUrl}/offers/${id}',
      callType: ApiCallType.PATCH,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwoPatches API Group Code

/// Start emailApi Group Code

class EmailApiGroup {
  static String getBaseUrl() =>
      'https://dev-iwo-email-cors.us-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static PostEmailCall postEmailCall = PostEmailCall();
  static PostSMSCall postSMSCall = PostSMSCall();
}

class PostEmailCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = EmailApiGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postEmail',
      apiUrl: '${baseUrl}/claude-email',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostSMSCall {
  Future<ApiCallResponse> call({
    String? requesterId = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = EmailApiGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postSMS',
      apiUrl: '${baseUrl}/claude-sms',
      callType: ApiCallType.POST,
      headers: {
        'requester-id': '${requesterId}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End emailApi Group Code

/// Start iwoAgentClient Group Code

class IwoAgentClientGroup {
  static String getBaseUrl() =>
      'https://dev-pp-agent-client.us-w2.cloudhub.io/api/v1';
  static Map<String, String> headers = {};
  static CreateAgentCall createAgentCall = CreateAgentCall();
  static GetAllAgentsCall getAllAgentsCall = GetAllAgentsCall();
  static GetAgentByIdCall getAgentByIdCall = GetAgentByIdCall();
  static GetAllClientsByAgentIdCall getAllClientsByAgentIdCall =
      GetAllClientsByAgentIdCall();
  static CreateClientByAgentIdCall createClientByAgentIdCall =
      CreateClientByAgentIdCall();
  static GetClientByAgentIdCall getClientByAgentIdCall =
      GetClientByAgentIdCall();
  static GetAllClientActivityByAgentIdCall getAllClientActivityByAgentIdCall =
      GetAllClientActivityByAgentIdCall();
  static GetClientActivityByAgentCall getClientActivityByAgentCall =
      GetClientActivityByAgentCall();
  static GetCrmByAgentCall getCrmByAgentCall = GetCrmByAgentCall();
}

class CreateAgentCall {
  Future<ApiCallResponse> call({
    dynamic? dataJson,
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createAgent',
      apiUrl: '${baseUrl}/my-agent',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllAgentsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllAgents',
      apiUrl: '${baseUrl}/my-agent',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAgentByIdCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAgentById',
      apiUrl: '${baseUrl}/my-agent/${agentId}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllClientsByAgentIdCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllClientsByAgentId',
      apiUrl: '${baseUrl}/my-client/${agentId}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateClientByAgentIdCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createClientByAgentId',
      apiUrl: '${baseUrl}/my-client/${agentId}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetClientByAgentIdCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
    String? clientId = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getClientByAgentId',
      apiUrl: '${baseUrl}/my-client/${agentId}/${clientId}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllClientActivityByAgentIdCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getAllClientActivityByAgentId',
      apiUrl: '${baseUrl}/activity/${agentId}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetClientActivityByAgentCall {
  Future<ApiCallResponse> call({
    String? agentId = '',
    String? clientId = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getClientActivityByAgent',
      apiUrl: '${baseUrl}/activity/${agentId}/${clientId}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCrmByAgentCall {
  Future<ApiCallResponse> call({
    String? agentID = '',
  }) async {
    final baseUrl = IwoAgentClientGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getCrmByAgent',
      apiUrl: '${baseUrl}/my-client/partnerpro/load-crm',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'agentID': agentID,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End iwoAgentClient Group Code

class GetPropertiesListCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    bool? zillowProperties,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getPropertiesList',
      apiUrl:
          'http://dev-iwo-seller-properties-api.us-w2.cloudhub.io/api/v1/properties/seller',
      callType: ApiCallType.GET,
      headers: {
        'requester-id': '${userId}',
      },
      params: {
        'zillowProperties': zillowProperties,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PropertyEstimateCall {
  static Future<ApiCallResponse> call({
    String? zpid = '87788805',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Property Estimate',
      apiUrl: 'https://us-housing-market-data1.p.rapidapi.com/zestimate',
      callType: ApiCallType.GET,
      headers: {
        'x-rapidapi-host': 'us-housing-market-data1.p.rapidapi.com',
        'x-rapidapi-key': '915dfbfba8msh724d11796631b15p11a9e7jsn74599d4844f4',
      },
      params: {
        'zpid': zpid,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? estimate(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.value''',
      ));
}

class PropertyComparablesCall {
  static Future<ApiCallResponse> call({
    String? address = '1644 W Wolfram St, Chicago, IL, 60657',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Property Comparables',
      apiUrl: 'https://us-housing-market-data1.p.rapidapi.com/propertyComps',
      callType: ApiCallType.GET,
      headers: {
        'x-rapidapi-host': 'us-housing-market-data1.p.rapidapi.com',
        'x-rapidapi-key': '915dfbfba8msh724d11796631b15p11a9e7jsn74599d4844f4',
      },
      params: {
        'address': address,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? comps(dynamic response) => getJsonField(
        response,
        r'''$.comps''',
        true,
      ) as List?;
}

class GooglePlacePickerCall {
  static Future<ApiCallResponse> call({
    String? input = '',
    String? components = 'country:us',
    String? location = '31.9686,-99.9018',
    int? radius = 500000,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'googlePlacePicker',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'input': input,
        'components': components,
        'location': location,
        'radius': radius,
        'key': EnvConfig.googleMapsKey,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? predictions(dynamic response) => getJsonField(
        response,
        r'''$.predictions''',
        true,
      ) as List?;
}

class GetPlaceNameCall {
  static Future<ApiCallResponse> call({
    double? latitude,
    double? longitude,
    double? apiKey,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getPlaceName',
      apiUrl:
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${EnvConfig.googleMapsKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? placeName(dynamic response) => (getJsonField(
        response,
        r'''$.results[0].formatted_address''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetGoogleGeoCodeCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getGoogleGeoCode',
      apiUrl:
          'https://maps.googleapis.com/maps/api/geocode/json?address=2101+West+82nd+Place,+Chicago,+IL,+USA&key=${EnvConfig.googleMapsKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPropertyzpidCall {
  static Future<ApiCallResponse> call({
    String? location = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getPropertyzpid',
      apiUrl:
          'https://us-housing-market-data1.p.rapidapi.com/propertyExtendedSearch',
      callType: ApiCallType.GET,
      headers: {
        'x-rapidapi-host': 'us-housing-market-data1.p.rapidapi.com',
        'x-rapidapi-key': '915dfbfba8msh724d11796631b15p11a9e7jsn74599d4844f4',
      },
      params: {
        'location': location,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? zpid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.zpid''',
      ));
  static List<String>? listZpid(dynamic response) => (getJsonField(
        response,
        r'''$.props[:].zpid''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PayShowingPartnerProCall {
  static Future<ApiCallResponse> call({
    dynamic? dataJson,
  }) async {
    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
${data}''';
    return ApiManager.instance.makeApiCall(
      callName: 'payShowingPartnerPro',
      apiUrl: 'https://dev-iwo-stripe-api.us-w2.cloudhub.io/api/v1/charge',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
