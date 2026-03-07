import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _isNewUser = await secureStorage.getBool('ff_isNewUser') ?? _isNewUser;
    });
    await _safeInitAsync(() async {
      _sellerIsMuteNotifications =
          await secureStorage.getBool('ff_sellerIsMuteNotifications') ??
              _sellerIsMuteNotifications;
    });
    await _safeInitAsync(() async {
      _sellerActiveWalkthrough =
          await secureStorage.getBool('ff_sellerActiveWalkthrough') ??
              _sellerActiveWalkthrough;
    });
    await _safeInitAsync(() async {
      _generatedPDF =
          await secureStorage.getString('ff_generatedPDF') ?? _generatedPDF;
    });
    await _safeInitAsync(() async {
      _PDFLink = await secureStorage.getString('ff_PDFLink') ?? _PDFLink;
    });
    await _safeInitAsync(() async {
      _v2 = await secureStorage.getBool('ff_v2') ?? _v2;
    });
    await _safeInitAsync(() async {
      _showPaywall =
          await secureStorage.getBool('ff_showPaywall') ?? _showPaywall;
    });
    await _safeInitAsync(() async {
      _enableNotification =
          await secureStorage.getBool('ff_enableNotification') ??
              _enableNotification;
    });
    await _safeInitAsync(() async {
      _tokenID = await secureStorage.getString('ff_tokenID') ?? _tokenID;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  bool _isNewUser = true;
  bool get isNewUser => _isNewUser;
  set isNewUser(bool value) {
    _isNewUser = value;
    secureStorage.setBool('ff_isNewUser', value);
  }

  void deleteIsNewUser() {
    secureStorage.delete(key: 'ff_isNewUser');
  }

  bool _sellerIsMuteNotifications = false;
  bool get sellerIsMuteNotifications => _sellerIsMuteNotifications;
  set sellerIsMuteNotifications(bool value) {
    _sellerIsMuteNotifications = value;
    secureStorage.setBool('ff_sellerIsMuteNotifications', value);
  }

  void deleteSellerIsMuteNotifications() {
    secureStorage.delete(key: 'ff_sellerIsMuteNotifications');
  }

  List<NotificationStruct> _sellerNotifications = [];
  List<NotificationStruct> get sellerNotifications => _sellerNotifications;
  set sellerNotifications(List<NotificationStruct> value) {
    _sellerNotifications = value;
  }

  void addToSellerNotifications(NotificationStruct value) {
    sellerNotifications.add(value);
  }

  void removeFromSellerNotifications(NotificationStruct value) {
    sellerNotifications.remove(value);
  }

  void removeAtIndexFromSellerNotifications(int index) {
    sellerNotifications.removeAt(index);
  }

  void updateSellerNotificationsAtIndex(
    int index,
    NotificationStruct Function(NotificationStruct) updateFn,
  ) {
    sellerNotifications[index] = updateFn(_sellerNotifications[index]);
  }

  void insertAtIndexInSellerNotifications(int index, NotificationStruct value) {
    sellerNotifications.insert(index, value);
  }

  List<PropertyStruct> _sellerListOfProperties = [];
  List<PropertyStruct> get sellerListOfProperties => _sellerListOfProperties;
  set sellerListOfProperties(List<PropertyStruct> value) {
    _sellerListOfProperties = value;
  }

  void addToSellerListOfProperties(PropertyStruct value) {
    sellerListOfProperties.add(value);
  }

  void removeFromSellerListOfProperties(PropertyStruct value) {
    sellerListOfProperties.remove(value);
  }

  void removeAtIndexFromSellerListOfProperties(int index) {
    sellerListOfProperties.removeAt(index);
  }

  void updateSellerListOfPropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    sellerListOfProperties[index] = updateFn(_sellerListOfProperties[index]);
  }

  void insertAtIndexInSellerListOfProperties(int index, PropertyStruct value) {
    sellerListOfProperties.insert(index, value);
  }

  bool _sellerActiveWalkthrough = true;
  bool get sellerActiveWalkthrough => _sellerActiveWalkthrough;
  set sellerActiveWalkthrough(bool value) {
    _sellerActiveWalkthrough = value;
    secureStorage.setBool('ff_sellerActiveWalkthrough', value);
  }

  void deleteSellerActiveWalkthrough() {
    secureStorage.delete(key: 'ff_sellerActiveWalkthrough');
  }

  List<PropertyStruct> _sellerWishlistedProperties = [];
  List<PropertyStruct> get sellerWishlistedProperties =>
      _sellerWishlistedProperties;
  set sellerWishlistedProperties(List<PropertyStruct> value) {
    _sellerWishlistedProperties = value;
  }

  void addToSellerWishlistedProperties(PropertyStruct value) {
    sellerWishlistedProperties.add(value);
  }

  void removeFromSellerWishlistedProperties(PropertyStruct value) {
    sellerWishlistedProperties.remove(value);
  }

  void removeAtIndexFromSellerWishlistedProperties(int index) {
    sellerWishlistedProperties.removeAt(index);
  }

  void updateSellerWishlistedPropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    sellerWishlistedProperties[index] =
        updateFn(_sellerWishlistedProperties[index]);
  }

  void insertAtIndexInSellerWishlistedProperties(
      int index, PropertyStruct value) {
    sellerWishlistedProperties.insert(index, value);
  }

  List<PropertyStruct> _sellerTopProperties = [];
  List<PropertyStruct> get sellerTopProperties => _sellerTopProperties;
  set sellerTopProperties(List<PropertyStruct> value) {
    _sellerTopProperties = value;
  }

  void addToSellerTopProperties(PropertyStruct value) {
    sellerTopProperties.add(value);
  }

  void removeFromSellerTopProperties(PropertyStruct value) {
    sellerTopProperties.remove(value);
  }

  void removeAtIndexFromSellerTopProperties(int index) {
    sellerTopProperties.removeAt(index);
  }

  void updateSellerTopPropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    sellerTopProperties[index] = updateFn(_sellerTopProperties[index]);
  }

  void insertAtIndexInSellerTopProperties(int index, PropertyStruct value) {
    sellerTopProperties.insert(index, value);
  }

  List<PropertyStruct> _sellerSimilarProperties = [];
  List<PropertyStruct> get sellerSimilarProperties => _sellerSimilarProperties;
  set sellerSimilarProperties(List<PropertyStruct> value) {
    _sellerSimilarProperties = value;
  }

  void addToSellerSimilarProperties(PropertyStruct value) {
    sellerSimilarProperties.add(value);
  }

  void removeFromSellerSimilarProperties(PropertyStruct value) {
    sellerSimilarProperties.remove(value);
  }

  void removeAtIndexFromSellerSimilarProperties(int index) {
    sellerSimilarProperties.removeAt(index);
  }

  void updateSellerSimilarPropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    sellerSimilarProperties[index] = updateFn(_sellerSimilarProperties[index]);
  }

  void insertAtIndexInSellerSimilarProperties(int index, PropertyStruct value) {
    sellerSimilarProperties.insert(index, value);
  }

  List<PropertyStruct> _listOfProperties = [];
  List<PropertyStruct> get listOfProperties => _listOfProperties;
  set listOfProperties(List<PropertyStruct> value) {
    _listOfProperties = value;
  }

  void addToListOfProperties(PropertyStruct value) {
    listOfProperties.add(value);
  }

  void removeFromListOfProperties(PropertyStruct value) {
    listOfProperties.remove(value);
  }

  void removeAtIndexFromListOfProperties(int index) {
    listOfProperties.removeAt(index);
  }

  void updateListOfPropertiesAtIndex(
    int index,
    PropertyStruct Function(PropertyStruct) updateFn,
  ) {
    listOfProperties[index] = updateFn(_listOfProperties[index]);
  }

  void insertAtIndexInListOfProperties(int index, PropertyStruct value) {
    listOfProperties.insert(index, value);
  }

  List<AppointmentStruct> _sellerAppointments = [];
  List<AppointmentStruct> get sellerAppointments => _sellerAppointments;
  set sellerAppointments(List<AppointmentStruct> value) {
    _sellerAppointments = value;
  }

  void addToSellerAppointments(AppointmentStruct value) {
    sellerAppointments.add(value);
  }

  void removeFromSellerAppointments(AppointmentStruct value) {
    sellerAppointments.remove(value);
  }

  void removeAtIndexFromSellerAppointments(int index) {
    sellerAppointments.removeAt(index);
  }

  void updateSellerAppointmentsAtIndex(
    int index,
    AppointmentStruct Function(AppointmentStruct) updateFn,
  ) {
    sellerAppointments[index] = updateFn(_sellerAppointments[index]);
  }

  void insertAtIndexInSellerAppointments(int index, AppointmentStruct value) {
    sellerAppointments.insert(index, value);
  }

  int _sellerPropertyViewCount = 0;
  int get sellerPropertyViewCount => _sellerPropertyViewCount;
  set sellerPropertyViewCount(int value) {
    _sellerPropertyViewCount = value;
  }

  List<OfferStruct> _Offers = [];
  List<OfferStruct> get Offers => _Offers;
  set Offers(List<OfferStruct> value) {
    _Offers = value;
  }

  void addToOffers(OfferStruct value) {
    Offers.add(value);
  }

  void removeFromOffers(OfferStruct value) {
    Offers.remove(value);
  }

  void removeAtIndexFromOffers(int index) {
    Offers.removeAt(index);
  }

  void updateOffersAtIndex(
    int index,
    OfferStruct Function(OfferStruct) updateFn,
  ) {
    Offers[index] = updateFn(_Offers[index]);
  }

  void insertAtIndexInOffers(int index, OfferStruct value) {
    Offers.insert(index, value);
  }

  List<MessageStruct> _sellerMessages = [];
  List<MessageStruct> get sellerMessages => _sellerMessages;
  set sellerMessages(List<MessageStruct> value) {
    _sellerMessages = value;
  }

  void addToSellerMessages(MessageStruct value) {
    sellerMessages.add(value);
  }

  void removeFromSellerMessages(MessageStruct value) {
    sellerMessages.remove(value);
  }

  void removeAtIndexFromSellerMessages(int index) {
    sellerMessages.removeAt(index);
  }

  void updateSellerMessagesAtIndex(
    int index,
    MessageStruct Function(MessageStruct) updateFn,
  ) {
    sellerMessages[index] = updateFn(_sellerMessages[index]);
  }

  void insertAtIndexInSellerMessages(int index, MessageStruct value) {
    sellerMessages.insert(index, value);
  }

  List<AppointmentStruct> _sellerInspections = [];
  List<AppointmentStruct> get sellerInspections => _sellerInspections;
  set sellerInspections(List<AppointmentStruct> value) {
    _sellerInspections = value;
  }

  void addToSellerInspections(AppointmentStruct value) {
    sellerInspections.add(value);
  }

  void removeFromSellerInspections(AppointmentStruct value) {
    sellerInspections.remove(value);
  }

  void removeAtIndexFromSellerInspections(int index) {
    sellerInspections.removeAt(index);
  }

  void updateSellerInspectionsAtIndex(
    int index,
    AppointmentStruct Function(AppointmentStruct) updateFn,
  ) {
    sellerInspections[index] = updateFn(_sellerInspections[index]);
  }

  void insertAtIndexInSellerInspections(int index, AppointmentStruct value) {
    sellerInspections.insert(index, value);
  }

  String _generatedPDF = '';
  String get generatedPDF => _generatedPDF;
  set generatedPDF(String value) {
    _generatedPDF = value;
    secureStorage.setString('ff_generatedPDF', value);
  }

  void deleteGeneratedPDF() {
    secureStorage.delete(key: 'ff_generatedPDF');
  }

  String _PDFLink = '';
  String get PDFLink => _PDFLink;
  set PDFLink(String value) {
    _PDFLink = value;
    secureStorage.setString('ff_PDFLink', value);
  }

  void deletePDFLink() {
    secureStorage.delete(key: 'ff_PDFLink');
  }

  bool _v2 = false;
  bool get v2 => _v2;
  set v2(bool value) {
    _v2 = value;
    secureStorage.setBool('ff_v2', value);
  }

  void deleteV2() {
    secureStorage.delete(key: 'ff_v2');
  }

  bool _searchQueryIsActive = false;
  bool get searchQueryIsActive => _searchQueryIsActive;
  set searchQueryIsActive(bool value) {
    _searchQueryIsActive = value;
  }

  bool _showPaywall = true;
  bool get showPaywall => _showPaywall;
  set showPaywall(bool value) {
    _showPaywall = value;
    secureStorage.setBool('ff_showPaywall', value);
  }

  void deleteShowPaywall() {
    secureStorage.delete(key: 'ff_showPaywall');
  }

  List<CustomMarkerStruct> _customMarker = [
    CustomMarkerStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"1\",\"latitude\":\"37.7749\",\"longitude\":\"-122.419\",\"price\":\"500k\",\"property_images\":\"[\\\"https://photos.zillowstatic.com/fp/8be3ac8e261a60e2f3d704976a19f288-uncropped_scaled_within_1344_1008.webp\\\"]\"}')),
    CustomMarkerStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"2\",\"latitude\":\"37.7895\",\"longitude\":\"-122.405\",\"price\":\"500\",\"property_images\":\"[\\\"https://photos.zillowstatic.com/fp/15ed8bc47e5f97730e53a89e9bc955cb-uncropped_scaled_within_1344_1008.webp\\\"]\"}'))
  ];
  List<CustomMarkerStruct> get customMarker => _customMarker;
  set customMarker(List<CustomMarkerStruct> value) {
    _customMarker = value;
  }

  void addToCustomMarker(CustomMarkerStruct value) {
    customMarker.add(value);
  }

  void removeFromCustomMarker(CustomMarkerStruct value) {
    customMarker.remove(value);
  }

  void removeAtIndexFromCustomMarker(int index) {
    customMarker.removeAt(index);
  }

  void updateCustomMarkerAtIndex(
    int index,
    CustomMarkerStruct Function(CustomMarkerStruct) updateFn,
  ) {
    customMarker[index] = updateFn(_customMarker[index]);
  }

  void insertAtIndexInCustomMarker(int index, CustomMarkerStruct value) {
    customMarker.insert(index, value);
  }

  bool _enableNotification = false;
  bool get enableNotification => _enableNotification;
  set enableNotification(bool value) {
    _enableNotification = value;
    secureStorage.setBool('ff_enableNotification', value);
  }

  void deleteEnableNotification() {
    secureStorage.delete(key: 'ff_enableNotification');
  }

  NewOfferStruct _currentOfferDraft = NewOfferStruct();
  NewOfferStruct get currentOfferDraft => _currentOfferDraft;
  set currentOfferDraft(NewOfferStruct value) {
    _currentOfferDraft = value;
  }

  void updateCurrentOfferDraftStruct(Function(NewOfferStruct) updateFn) {
    updateFn(_currentOfferDraft);
  }

  bool _isNavigating = false;
  bool get isNavigating => _isNavigating;
  set isNavigating(bool value) {
    _isNavigating = value;
  }

  String _fromEmail = 'support@mypartnerpro.com';
  String get fromEmail => _fromEmail;
  set fromEmail(String value) {
    _fromEmail = value;
  }

  String _redirectUrl = 'https://testflight.apple.com/join/Fys7HbR3';
  String get redirectUrl => _redirectUrl;
  set redirectUrl(String value) {
    _redirectUrl = value;
  }

  String _senderPhoneNumber = '19728857156';
  String get senderPhoneNumber => _senderPhoneNumber;
  set senderPhoneNumber(String value) {
    _senderPhoneNumber = value;
  }

  String _tokenID = '';
  String get tokenID => _tokenID;
  set tokenID(String value) {
    _tokenID = value;
    secureStorage.setString('ff_tokenID', value);
  }

  void deleteTokenID() {
    secureStorage.delete(key: 'ff_tokenID');
  }

  String _appVersion = 'version 1.0.1 / Build 22';
  String get appVersion => _appVersion;
  set appVersion(String value) {
    _appVersion = value;
  }

  String _tcDeskURL = 'https://tc-iwriteoffers.flutterflow.app/';
  String get tcDeskURL => _tcDeskURL;
  set tcDeskURL(String value) {
    _tcDeskURL = value;
  }

  String _appLogo =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/partner-pro-i7cxfg/assets/hmx5ppn0h4bf/partner_pro_black-01.png';
  String get appLogo => _appLogo;
  set appLogo(String value) {
    _appLogo = value;
  }

  NewOfferStruct _tempOfferCompare = NewOfferStruct();
  NewOfferStruct get tempOfferCompare => _tempOfferCompare;
  set tempOfferCompare(NewOfferStruct value) {
    _tempOfferCompare = value;
  }

  void updateTempOfferCompareStruct(Function(NewOfferStruct) updateFn) {
    updateFn(_tempOfferCompare);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
