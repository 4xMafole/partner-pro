import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/document_model.dart';
import '../../data/repositories/document_repository.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserDocuments extends DocumentEvent {
  final String userId, requesterId;
  const LoadUserDocuments({required this.userId, required this.requesterId});
  @override
  List<Object?> get props => [userId, requesterId];
}

class LoadPropertyDocuments extends DocumentEvent {
  final String propertyId, requesterId;
  const LoadPropertyDocuments(
      {required this.propertyId, required this.requesterId});
  @override
  List<Object?> get props => [propertyId, requesterId];
}

class UploadDocument extends DocumentEvent {
  final String requesterId,
      userId,
      documentDirectory,
      documentFile,
      documentType,
      documentName,
      documentSize;
  final String? propertyId, sellerId;
  const UploadDocument(
      {required this.requesterId,
      required this.userId,
      required this.documentDirectory,
      required this.documentFile,
      required this.documentType,
      required this.documentName,
      required this.documentSize,
      this.propertyId,
      this.sellerId});
  @override
  List<Object?> get props => [userId, documentName];
}

class GeneratePdf extends DocumentEvent {
  final String sellerName, buyerName, address, purchasePrice, loanType;
  const GeneratePdf(
      {required this.sellerName,
      required this.buyerName,
      required this.address,
      required this.purchasePrice,
      required this.loanType});
  @override
  List<Object?> get props =>
      [sellerName, buyerName, address, purchasePrice, loanType];
}

class CreateSigningSubmission extends DocumentEvent {
  final int templateId;
  final List<Map<String, dynamic>> submitters;
  const CreateSigningSubmission(
      {required this.templateId, required this.submitters});
  @override
  List<Object?> get props => [templateId, submitters];
}

class CheckSubmissionStatus extends DocumentEvent {
  final int submissionId;
  const CheckSubmissionStatus({required this.submissionId});
  @override
  List<Object?> get props => [submissionId];
}

class LoadTemplates extends DocumentEvent {}

class DocumentState extends Equatable {
  final bool isLoading, isUploading, isGeneratingPdf;
  final String? error, successMessage, generatedPdfUrl;
  final List<DocumentModel> documents;
  final Map<String, dynamic>? submissionData;
  final List<Map<String, dynamic>> templates;

  const DocumentState(
      {this.isLoading = false,
      this.isUploading = false,
      this.isGeneratingPdf = false,
      this.error,
      this.successMessage,
      this.documents = const [],
      this.generatedPdfUrl,
      this.submissionData,
      this.templates = const []});

  DocumentState copyWith(
      {bool? isLoading,
      bool? isUploading,
      bool? isGeneratingPdf,
      String? error,
      String? successMessage,
      List<DocumentModel>? documents,
      String? generatedPdfUrl,
      Map<String, dynamic>? submissionData,
      List<Map<String, dynamic>>? templates}) {
    return DocumentState(
        isLoading: isLoading ?? this.isLoading,
        isUploading: isUploading ?? this.isUploading,
        isGeneratingPdf: isGeneratingPdf ?? this.isGeneratingPdf,
        error: error,
        successMessage: successMessage,
        documents: documents ?? this.documents,
        generatedPdfUrl: generatedPdfUrl ?? this.generatedPdfUrl,
        submissionData: submissionData ?? this.submissionData,
        templates: templates ?? this.templates);
  }

  @override
  List<Object?> get props => [
        isLoading,
        isUploading,
        isGeneratingPdf,
        error,
        successMessage,
        documents,
        generatedPdfUrl,
        submissionData,
        templates
      ];
}

@injectable
class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final DocumentRepository _repository;

  DocumentBloc(this._repository) : super(const DocumentState()) {
    on<LoadUserDocuments>(_onLoadUser);
    on<LoadPropertyDocuments>(_onLoadProperty);
    on<UploadDocument>(_onUpload);
    on<GeneratePdf>(_onGeneratePdf);
    on<CreateSigningSubmission>(_onCreateSigning);
    on<CheckSubmissionStatus>(_onCheckStatus);
    on<LoadTemplates>(_onLoadTemplates);
  }

  Future<void> _onLoadUser(
      LoadUserDocuments e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getUserDocuments(
        userId: e.userId, requesterId: e.requesterId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (docs) => emit(state.copyWith(isLoading: false, documents: docs)));
  }

  Future<void> _onLoadProperty(
      LoadPropertyDocuments e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getPropertyDocuments(
        propertyId: e.propertyId, requesterId: e.requesterId);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (docs) => emit(state.copyWith(isLoading: false, documents: docs)));
  }

  Future<void> _onUpload(UploadDocument e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isUploading: true, error: null));
    final r = await _repository.uploadDocument(
        requesterId: e.requesterId,
        userId: e.userId,
        documentDirectory: e.documentDirectory,
        documentFile: e.documentFile,
        documentType: e.documentType,
        documentName: e.documentName,
        documentSize: e.documentSize,
        propertyId: e.propertyId,
        sellerId: e.sellerId);
    r.fold((f) => emit(state.copyWith(isUploading: false, error: f.message)),
        (doc) {
      final updated = [...state.documents, doc];
      emit(state.copyWith(
          isUploading: false,
          documents: updated,
          successMessage: 'Document uploaded'));
    });
  }

  Future<void> _onGeneratePdf(
      GeneratePdf e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isGeneratingPdf: true, error: null));
    final r = await _repository.generatePdf(
        sellerName: e.sellerName,
        buyerName: e.buyerName,
        address: e.address,
        purchasePrice: e.purchasePrice,
        loanType: e.loanType);
    r.fold(
        (f) => emit(state.copyWith(isGeneratingPdf: false, error: f.message)),
        (d) => emit(state.copyWith(
            isGeneratingPdf: false,
            generatedPdfUrl: d['url']?.toString(),
            successMessage: 'PDF generated')));
  }

  Future<void> _onCreateSigning(
      CreateSigningSubmission e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.createSubmission(
        templateId: e.templateId, submitters: e.submitters);
    r.fold(
        (f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (d) => emit(state.copyWith(
            isLoading: false,
            submissionData: d,
            successMessage: 'Signing request sent')));
  }

  Future<void> _onCheckStatus(
      CheckSubmissionStatus e, Emitter<DocumentState> emit) async {
    final r = await _repository.getSubmission(e.submissionId);
    r.fold((f) => emit(state.copyWith(error: f.message)),
        (d) => emit(state.copyWith(submissionData: d)));
  }

  Future<void> _onLoadTemplates(
      LoadTemplates e, Emitter<DocumentState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getTemplates();
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (d) => emit(state.copyWith(isLoading: false, templates: d)));
  }
}
