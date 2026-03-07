// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewAddendumsStruct extends FFFirebaseStruct {
  NewAddendumsStruct({
    String? id,
    String? name,
    String? description,
    String? sellerSign,
    String? buyerSign,
    String? documentId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _description = description,
        _sellerSign = sellerSign,
        _buyerSign = buyerSign,
        _documentId = documentId,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "seller_sign" field.
  String? _sellerSign;
  String get sellerSign => _sellerSign ?? '';
  set sellerSign(String? val) => _sellerSign = val;

  bool hasSellerSign() => _sellerSign != null;

  // "buyer_sign" field.
  String? _buyerSign;
  String get buyerSign => _buyerSign ?? '';
  set buyerSign(String? val) => _buyerSign = val;

  bool hasBuyerSign() => _buyerSign != null;

  // "document_id" field.
  String? _documentId;
  String get documentId => _documentId ?? '';
  set documentId(String? val) => _documentId = val;

  bool hasDocumentId() => _documentId != null;

  static NewAddendumsStruct fromMap(Map<String, dynamic> data) =>
      NewAddendumsStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        sellerSign: data['seller_sign'] as String?,
        buyerSign: data['buyer_sign'] as String?,
        documentId: data['document_id'] as String?,
      );

  static NewAddendumsStruct? maybeFromMap(dynamic data) => data is Map
      ? NewAddendumsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'description': _description,
        'seller_sign': _sellerSign,
        'buyer_sign': _buyerSign,
        'document_id': _documentId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'seller_sign': serializeParam(
          _sellerSign,
          ParamType.String,
        ),
        'buyer_sign': serializeParam(
          _buyerSign,
          ParamType.String,
        ),
        'document_id': serializeParam(
          _documentId,
          ParamType.String,
        ),
      }.withoutNulls;

  static NewAddendumsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewAddendumsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        sellerSign: deserializeParam(
          data['seller_sign'],
          ParamType.String,
          false,
        ),
        buyerSign: deserializeParam(
          data['buyer_sign'],
          ParamType.String,
          false,
        ),
        documentId: deserializeParam(
          data['document_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NewAddendumsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewAddendumsStruct &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        sellerSign == other.sellerSign &&
        buyerSign == other.buyerSign &&
        documentId == other.documentId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, name, description, sellerSign, buyerSign, documentId]);
}

NewAddendumsStruct createNewAddendumsStruct({
  String? id,
  String? name,
  String? description,
  String? sellerSign,
  String? buyerSign,
  String? documentId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NewAddendumsStruct(
      id: id,
      name: name,
      description: description,
      sellerSign: sellerSign,
      buyerSign: buyerSign,
      documentId: documentId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NewAddendumsStruct? updateNewAddendumsStruct(
  NewAddendumsStruct? newAddendums, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    newAddendums
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNewAddendumsStructData(
  Map<String, dynamic> firestoreData,
  NewAddendumsStruct? newAddendums,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (newAddendums == null) {
    return;
  }
  if (newAddendums.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && newAddendums.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final newAddendumsData =
      getNewAddendumsFirestoreData(newAddendums, forFieldValue);
  final nestedData =
      newAddendumsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = newAddendums.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNewAddendumsFirestoreData(
  NewAddendumsStruct? newAddendums, [
  bool forFieldValue = false,
]) {
  if (newAddendums == null) {
    return {};
  }
  final firestoreData = mapToFirestore(newAddendums.toMap());

  // Add any Firestore field values
  newAddendums.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNewAddendumsListFirestoreData(
  List<NewAddendumsStruct>? newAddendumss,
) =>
    newAddendumss?.map((e) => getNewAddendumsFirestoreData(e, true)).toList() ??
    [];
