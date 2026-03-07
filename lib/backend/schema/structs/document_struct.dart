// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DocumentStruct extends FFFirebaseStruct {
  DocumentStruct({
    String? id,
    String? userId,
    String? sellerId,
    String? propertyId,
    String? documentDirectory,
    String? documentName,
    String? documentType,
    int? documentVerion,
    String? documentSize,
    String? status,
    String? documentFile,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? documentApproved,
    String? documentApprovedBy,
    String? documentReviewed,
    String? documentReviewedBy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _userId = userId,
        _sellerId = sellerId,
        _propertyId = propertyId,
        _documentDirectory = documentDirectory,
        _documentName = documentName,
        _documentType = documentType,
        _documentVerion = documentVerion,
        _documentSize = documentSize,
        _status = status,
        _documentFile = documentFile,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _createdBy = createdBy,
        _updatedBy = updatedBy,
        _documentApproved = documentApproved,
        _documentApprovedBy = documentApprovedBy,
        _documentReviewed = documentReviewed,
        _documentReviewedBy = documentReviewedBy,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "seller_id" field.
  String? _sellerId;
  String get sellerId => _sellerId ?? '';
  set sellerId(String? val) => _sellerId = val;

  bool hasSellerId() => _sellerId != null;

  // "property_id" field.
  String? _propertyId;
  String get propertyId => _propertyId ?? '';
  set propertyId(String? val) => _propertyId = val;

  bool hasPropertyId() => _propertyId != null;

  // "document_directory" field.
  String? _documentDirectory;
  String get documentDirectory => _documentDirectory ?? '';
  set documentDirectory(String? val) => _documentDirectory = val;

  bool hasDocumentDirectory() => _documentDirectory != null;

  // "document_name" field.
  String? _documentName;
  String get documentName => _documentName ?? '';
  set documentName(String? val) => _documentName = val;

  bool hasDocumentName() => _documentName != null;

  // "document_type" field.
  String? _documentType;
  String get documentType => _documentType ?? '';
  set documentType(String? val) => _documentType = val;

  bool hasDocumentType() => _documentType != null;

  // "document_verion" field.
  int? _documentVerion;
  int get documentVerion => _documentVerion ?? 0;
  set documentVerion(int? val) => _documentVerion = val;

  void incrementDocumentVerion(int amount) =>
      documentVerion = documentVerion + amount;

  bool hasDocumentVerion() => _documentVerion != null;

  // "document_size" field.
  String? _documentSize;
  String get documentSize => _documentSize ?? '';
  set documentSize(String? val) => _documentSize = val;

  bool hasDocumentSize() => _documentSize != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "document_file" field.
  String? _documentFile;
  String get documentFile => _documentFile ?? '';
  set documentFile(String? val) => _documentFile = val;

  bool hasDocumentFile() => _documentFile != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "document_approved" field.
  String? _documentApproved;
  String get documentApproved => _documentApproved ?? '';
  set documentApproved(String? val) => _documentApproved = val;

  bool hasDocumentApproved() => _documentApproved != null;

  // "document_approved_by" field.
  String? _documentApprovedBy;
  String get documentApprovedBy => _documentApprovedBy ?? '';
  set documentApprovedBy(String? val) => _documentApprovedBy = val;

  bool hasDocumentApprovedBy() => _documentApprovedBy != null;

  // "document_reviewed" field.
  String? _documentReviewed;
  String get documentReviewed => _documentReviewed ?? '';
  set documentReviewed(String? val) => _documentReviewed = val;

  bool hasDocumentReviewed() => _documentReviewed != null;

  // "document_reviewed_by" field.
  String? _documentReviewedBy;
  String get documentReviewedBy => _documentReviewedBy ?? '';
  set documentReviewedBy(String? val) => _documentReviewedBy = val;

  bool hasDocumentReviewedBy() => _documentReviewedBy != null;

  static DocumentStruct fromMap(Map<String, dynamic> data) => DocumentStruct(
        id: data['id'] as String?,
        userId: data['user_id'] as String?,
        sellerId: data['seller_id'] as String?,
        propertyId: data['property_id'] as String?,
        documentDirectory: data['document_directory'] as String?,
        documentName: data['document_name'] as String?,
        documentType: data['document_type'] as String?,
        documentVerion: castToType<int>(data['document_verion']),
        documentSize: data['document_size'] as String?,
        status: data['status'] as String?,
        documentFile: data['document_file'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
        documentApproved: data['document_approved'] as String?,
        documentApprovedBy: data['document_approved_by'] as String?,
        documentReviewed: data['document_reviewed'] as String?,
        documentReviewedBy: data['document_reviewed_by'] as String?,
      );

  static DocumentStruct? maybeFromMap(dynamic data) =>
      data is Map ? DocumentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'user_id': _userId,
        'seller_id': _sellerId,
        'property_id': _propertyId,
        'document_directory': _documentDirectory,
        'document_name': _documentName,
        'document_type': _documentType,
        'document_verion': _documentVerion,
        'document_size': _documentSize,
        'status': _status,
        'document_file': _documentFile,
        'created_at': _createdAt,
        'updated_at': _updatedAt,
        'created_by': _createdBy,
        'updated_by': _updatedBy,
        'document_approved': _documentApproved,
        'document_approved_by': _documentApprovedBy,
        'document_reviewed': _documentReviewed,
        'document_reviewed_by': _documentReviewedBy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'seller_id': serializeParam(
          _sellerId,
          ParamType.String,
        ),
        'property_id': serializeParam(
          _propertyId,
          ParamType.String,
        ),
        'document_directory': serializeParam(
          _documentDirectory,
          ParamType.String,
        ),
        'document_name': serializeParam(
          _documentName,
          ParamType.String,
        ),
        'document_type': serializeParam(
          _documentType,
          ParamType.String,
        ),
        'document_verion': serializeParam(
          _documentVerion,
          ParamType.int,
        ),
        'document_size': serializeParam(
          _documentSize,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'document_file': serializeParam(
          _documentFile,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'document_approved': serializeParam(
          _documentApproved,
          ParamType.String,
        ),
        'document_approved_by': serializeParam(
          _documentApprovedBy,
          ParamType.String,
        ),
        'document_reviewed': serializeParam(
          _documentReviewed,
          ParamType.String,
        ),
        'document_reviewed_by': serializeParam(
          _documentReviewedBy,
          ParamType.String,
        ),
      }.withoutNulls;

  static DocumentStruct fromSerializableMap(Map<String, dynamic> data) =>
      DocumentStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        sellerId: deserializeParam(
          data['seller_id'],
          ParamType.String,
          false,
        ),
        propertyId: deserializeParam(
          data['property_id'],
          ParamType.String,
          false,
        ),
        documentDirectory: deserializeParam(
          data['document_directory'],
          ParamType.String,
          false,
        ),
        documentName: deserializeParam(
          data['document_name'],
          ParamType.String,
          false,
        ),
        documentType: deserializeParam(
          data['document_type'],
          ParamType.String,
          false,
        ),
        documentVerion: deserializeParam(
          data['document_verion'],
          ParamType.int,
          false,
        ),
        documentSize: deserializeParam(
          data['document_size'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        documentFile: deserializeParam(
          data['document_file'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        documentApproved: deserializeParam(
          data['document_approved'],
          ParamType.String,
          false,
        ),
        documentApprovedBy: deserializeParam(
          data['document_approved_by'],
          ParamType.String,
          false,
        ),
        documentReviewed: deserializeParam(
          data['document_reviewed'],
          ParamType.String,
          false,
        ),
        documentReviewedBy: deserializeParam(
          data['document_reviewed_by'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DocumentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DocumentStruct &&
        id == other.id &&
        userId == other.userId &&
        sellerId == other.sellerId &&
        propertyId == other.propertyId &&
        documentDirectory == other.documentDirectory &&
        documentName == other.documentName &&
        documentType == other.documentType &&
        documentVerion == other.documentVerion &&
        documentSize == other.documentSize &&
        status == other.status &&
        documentFile == other.documentFile &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        createdBy == other.createdBy &&
        updatedBy == other.updatedBy &&
        documentApproved == other.documentApproved &&
        documentApprovedBy == other.documentApprovedBy &&
        documentReviewed == other.documentReviewed &&
        documentReviewedBy == other.documentReviewedBy;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        userId,
        sellerId,
        propertyId,
        documentDirectory,
        documentName,
        documentType,
        documentVerion,
        documentSize,
        status,
        documentFile,
        createdAt,
        updatedAt,
        createdBy,
        updatedBy,
        documentApproved,
        documentApprovedBy,
        documentReviewed,
        documentReviewedBy
      ]);
}

DocumentStruct createDocumentStruct({
  String? id,
  String? userId,
  String? sellerId,
  String? propertyId,
  String? documentDirectory,
  String? documentName,
  String? documentType,
  int? documentVerion,
  String? documentSize,
  String? status,
  String? documentFile,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  String? documentApproved,
  String? documentApprovedBy,
  String? documentReviewed,
  String? documentReviewedBy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DocumentStruct(
      id: id,
      userId: userId,
      sellerId: sellerId,
      propertyId: propertyId,
      documentDirectory: documentDirectory,
      documentName: documentName,
      documentType: documentType,
      documentVerion: documentVerion,
      documentSize: documentSize,
      status: status,
      documentFile: documentFile,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
      documentApproved: documentApproved,
      documentApprovedBy: documentApprovedBy,
      documentReviewed: documentReviewed,
      documentReviewedBy: documentReviewedBy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DocumentStruct? updateDocumentStruct(
  DocumentStruct? document, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    document
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDocumentStructData(
  Map<String, dynamic> firestoreData,
  DocumentStruct? document,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (document == null) {
    return;
  }
  if (document.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && document.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final documentData = getDocumentFirestoreData(document, forFieldValue);
  final nestedData = documentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = document.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDocumentFirestoreData(
  DocumentStruct? document, [
  bool forFieldValue = false,
]) {
  if (document == null) {
    return {};
  }
  final firestoreData = mapToFirestore(document.toMap());

  // Add any Firestore field values
  document.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDocumentListFirestoreData(
  List<DocumentStruct>? documents,
) =>
    documents?.map((e) => getDocumentFirestoreData(e, true)).toList() ?? [];
