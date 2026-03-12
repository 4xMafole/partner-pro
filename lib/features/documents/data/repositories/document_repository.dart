import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/document_remote_datasource.dart';
import '../models/document_model.dart';

@lazySingleton
class DocumentRepository {
  final DocumentRemoteDataSource _remote;

  DocumentRepository(this._remote);

  Future<Either<Failure, DocumentModel>> getDocument(
      {required String documentId, required String requesterId}) async {
    try {
      return Right(DocumentModel.fromJson(await _remote.getDocument(
          documentId: documentId, requesterId: requesterId)));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<DocumentModel>>> getUserDocuments(
      {required String userId, required String requesterId}) async {
    try {
      final data = await _remote.getUserDocuments(
          userId: userId, requesterId: requesterId);
      return Right(data.map((j) => DocumentModel.fromJson(j)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<DocumentModel>>> getPropertyDocuments(
      {required String propertyId, required String requesterId}) async {
    try {
      final data = await _remote.getPropertyDocuments(
          propertyId: propertyId, requesterId: requesterId);
      return Right(data.map((j) => DocumentModel.fromJson(j)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, DocumentModel>> uploadDocument({
    required String requesterId,
    required String userId,
    required String documentDirectory,
    required String documentFile,
    required String documentType,
    required String documentName,
    required String documentSize,
    String? propertyId,
    String? sellerId,
  }) async {
    try {
      final data = await _remote.uploadDocument(
        requesterId: requesterId,
        userId: userId,
        documentDirectory: documentDirectory,
        documentFile: documentFile,
        documentType: documentType,
        documentName: documentName,
        documentSize: documentSize,
        propertyId: propertyId,
        sellerId: sellerId,
      );
      return Right(DocumentModel.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getTemplates() async {
    try {
      return Right(await _remote.getTemplates());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createSubmission({
    required int templateId,
    required List<Map<String, dynamic>> submitters,
  }) async {
    try {
      return Right(await _remote.createSubmission(
          templateId: templateId, submitters: submitters));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getSubmission(
      int submissionId) async {
    try {
      return Right(await _remote.getSubmission(submissionId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> generatePdf({
    required String sellerName,
    required String buyerName,
    required String address,
    required String purchasePrice,
    required String loanType,
  }) async {
    try {
      return Right(await _remote.generatePdf(
        sellerName: sellerName,
        buyerName: buyerName,
        address: address,
        purchasePrice: purchasePrice,
        loanType: loanType,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
