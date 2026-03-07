// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppointmentStruct extends FFFirebaseStruct {
  AppointmentStruct({
    String? id,
    PropertyStruct? property,
    DateTime? date,
    Status? status,
    String? address,
    String? photo,
    AppointmentType? type,
    int? price,
    Address1Struct? addressLine,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _property = property,
        _date = date,
        _status = status,
        _address = address,
        _photo = photo,
        _type = type,
        _price = price,
        _addressLine = addressLine,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "property" field.
  PropertyStruct? _property;
  PropertyStruct get property => _property ?? PropertyStruct();
  set property(PropertyStruct? val) => _property = val;

  void updateProperty(Function(PropertyStruct) updateFn) {
    updateFn(_property ??= PropertyStruct());
  }

  bool hasProperty() => _property != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "status" field.
  Status? _status;
  Status get status => _status ?? Status.Pending;
  set status(Status? val) => _status = val;

  bool hasStatus() => _status != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  set photo(String? val) => _photo = val;

  bool hasPhoto() => _photo != null;

  // "type" field.
  AppointmentType? _type;
  AppointmentType? get type => _type;
  set type(AppointmentType? val) => _type = val;

  bool hasType() => _type != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "addressLine" field.
  Address1Struct? _addressLine;
  Address1Struct get addressLine => _addressLine ?? Address1Struct();
  set addressLine(Address1Struct? val) => _addressLine = val;

  void updateAddressLine(Function(Address1Struct) updateFn) {
    updateFn(_addressLine ??= Address1Struct());
  }

  bool hasAddressLine() => _addressLine != null;

  static AppointmentStruct fromMap(Map<String, dynamic> data) =>
      AppointmentStruct(
        id: data['id'] as String?,
        property: data['property'] is PropertyStruct
            ? data['property']
            : PropertyStruct.maybeFromMap(data['property']),
        date: data['date'] as DateTime?,
        status: data['status'] is Status
            ? data['status']
            : deserializeEnum<Status>(data['status']),
        address: data['address'] as String?,
        photo: data['photo'] as String?,
        type: data['type'] is AppointmentType
            ? data['type']
            : deserializeEnum<AppointmentType>(data['type']),
        price: castToType<int>(data['price']),
        addressLine: data['addressLine'] is Address1Struct
            ? data['addressLine']
            : Address1Struct.maybeFromMap(data['addressLine']),
      );

  static AppointmentStruct? maybeFromMap(dynamic data) => data is Map
      ? AppointmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'property': _property?.toMap(),
        'date': _date,
        'status': _status?.serialize(),
        'address': _address,
        'photo': _photo,
        'type': _type?.serialize(),
        'price': _price,
        'addressLine': _addressLine?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'property': serializeParam(
          _property,
          ParamType.DataStruct,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.Enum,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'photo': serializeParam(
          _photo,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.Enum,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'addressLine': serializeParam(
          _addressLine,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static AppointmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      AppointmentStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        property: deserializeStructParam(
          data['property'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyStruct.fromSerializableMap,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam<Status>(
          data['status'],
          ParamType.Enum,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        photo: deserializeParam(
          data['photo'],
          ParamType.String,
          false,
        ),
        type: deserializeParam<AppointmentType>(
          data['type'],
          ParamType.Enum,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        addressLine: deserializeStructParam(
          data['addressLine'],
          ParamType.DataStruct,
          false,
          structBuilder: Address1Struct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'AppointmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AppointmentStruct &&
        id == other.id &&
        property == other.property &&
        date == other.date &&
        status == other.status &&
        address == other.address &&
        photo == other.photo &&
        type == other.type &&
        price == other.price &&
        addressLine == other.addressLine;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, property, date, status, address, photo, type, price, addressLine]);
}

AppointmentStruct createAppointmentStruct({
  String? id,
  PropertyStruct? property,
  DateTime? date,
  Status? status,
  String? address,
  String? photo,
  AppointmentType? type,
  int? price,
  Address1Struct? addressLine,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AppointmentStruct(
      id: id,
      property: property ?? (clearUnsetFields ? PropertyStruct() : null),
      date: date,
      status: status,
      address: address,
      photo: photo,
      type: type,
      price: price,
      addressLine: addressLine ?? (clearUnsetFields ? Address1Struct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AppointmentStruct? updateAppointmentStruct(
  AppointmentStruct? appointment, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    appointment
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAppointmentStructData(
  Map<String, dynamic> firestoreData,
  AppointmentStruct? appointment,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (appointment == null) {
    return;
  }
  if (appointment.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && appointment.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final appointmentData =
      getAppointmentFirestoreData(appointment, forFieldValue);
  final nestedData =
      appointmentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = appointment.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAppointmentFirestoreData(
  AppointmentStruct? appointment, [
  bool forFieldValue = false,
]) {
  if (appointment == null) {
    return {};
  }
  final firestoreData = mapToFirestore(appointment.toMap());

  // Handle nested data for "property" field.
  addPropertyStructData(
    firestoreData,
    appointment.hasProperty() ? appointment.property : null,
    'property',
    forFieldValue,
  );

  // Handle nested data for "addressLine" field.
  addAddress1StructData(
    firestoreData,
    appointment.hasAddressLine() ? appointment.addressLine : null,
    'addressLine',
    forFieldValue,
  );

  // Add any Firestore field values
  appointment.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAppointmentListFirestoreData(
  List<AppointmentStruct>? appointments,
) =>
    appointments?.map((e) => getAppointmentFirestoreData(e, true)).toList() ??
    [];
