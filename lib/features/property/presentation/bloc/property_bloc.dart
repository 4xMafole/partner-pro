import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/property_model.dart';
import '../../data/repositories/property_repository.dart';

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
  @override
  List<Object?> get props => [];
}

class LoadProperties extends PropertyEvent {
  final String requesterId;
  final String? zipCode, city, state, homeType, statusType;
  final int? minPrice,
      maxPrice,
      minBeds,
      maxBeds,
      minBaths,
      maxBaths,
      minSquareFeet,
      maxSquareFeet,
      minYearBuilt,
      maxYearBuilt;
  final List<String>? homeTypes;
  const LoadProperties(
      {required this.requesterId,
      this.zipCode,
      this.city,
      this.state,
      this.homeType,
      this.statusType,
      this.minPrice,
      this.maxPrice,
      this.minBeds,
      this.maxBeds,
      this.minBaths,
      this.maxBaths,
      this.minSquareFeet,
      this.maxSquareFeet,
      this.minYearBuilt,
      this.maxYearBuilt,
      this.homeTypes});
  @override
  List<Object?> get props => [
        requesterId,
        zipCode,
        city,
        state,
        homeType,
        statusType,
        minPrice,
        maxPrice,
        minBeds,
        maxBeds,
        minBaths,
        maxBaths,
        minSquareFeet,
        maxSquareFeet,
        minYearBuilt,
        maxYearBuilt,
        homeTypes,
      ];
}

class LoadPropertiesByZip extends PropertyEvent {
  final String zipId, requesterId;
  const LoadPropertiesByZip({required this.zipId, required this.requesterId});
  @override
  List<Object?> get props => [zipId, requesterId];
}

class ApplyFilter extends PropertyEvent {
  final int? minPrice,
      maxPrice,
      minBeds,
      maxBeds,
      minBaths,
      maxBaths,
      minSquareFeet,
      maxSquareFeet,
      minYearBuilt,
      maxYearBuilt;
  final List<String>? homeTypes;
  const ApplyFilter(
      {this.minPrice,
      this.maxPrice,
      this.minBeds,
      this.maxBeds,
      this.minBaths,
      this.maxBaths,
      this.minSquareFeet,
      this.maxSquareFeet,
      this.minYearBuilt,
      this.maxYearBuilt,
      this.homeTypes});
  @override
  List<Object?> get props => [
        minPrice,
        maxPrice,
        minBeds,
        maxBeds,
        minBaths,
        maxBaths,
        minSquareFeet,
        maxSquareFeet,
        minYearBuilt,
        maxYearBuilt,
        homeTypes
      ];
}

class ClearFilter extends PropertyEvent {}

class LoadFavorites extends PropertyEvent {
  final String userId, requesterId;
  const LoadFavorites({required this.userId, required this.requesterId});
  @override
  List<Object?> get props => [userId, requesterId];
}

class AddFavorite extends PropertyEvent {
  final String userId, propertyId, requesterId;
  const AddFavorite(
      {required this.userId,
      required this.propertyId,
      required this.requesterId});
  @override
  List<Object?> get props => [userId, propertyId, requesterId];
}

class RemoveFavorite extends PropertyEvent {
  final String userId, favoriteId, requesterId;
  const RemoveFavorite(
      {required this.userId,
      required this.favoriteId,
      required this.requesterId});
  @override
  List<Object?> get props => [userId, favoriteId, requesterId];
}

class LoadSavedSearches extends PropertyEvent {
  final String userId, requesterId;
  const LoadSavedSearches({required this.userId, required this.requesterId});
  @override
  List<Object?> get props => [userId, requesterId];
}

class SaveSearch extends PropertyEvent {
  final String userId, requesterId;
  final Map<String, dynamic> searchData;
  const SaveSearch(
      {required this.userId,
      required this.searchData,
      required this.requesterId});
  @override
  List<Object?> get props => [userId, searchData, requesterId];
}

class DeleteSavedSearch extends PropertyEvent {
  final String searchId, requesterId;
  const DeleteSavedSearch({required this.searchId, required this.requesterId});
  @override
  List<Object?> get props => [searchId, requesterId];
}

class LoadShowings extends PropertyEvent {
  final String userId, requesterId;
  const LoadShowings({required this.userId, required this.requesterId});
  @override
  List<Object?> get props => [userId, requesterId];
}

class CreateShowing extends PropertyEvent {
  final String userId, propertyId, date, time, requesterId;
  const CreateShowing(
      {required this.userId,
      required this.propertyId,
      required this.date,
      required this.time,
      required this.requesterId});
  @override
  List<Object?> get props => [userId, propertyId, date, time, requesterId];
}

class CancelShowing extends PropertyEvent {
  final String showingId, requesterId;
  const CancelShowing({required this.showingId, required this.requesterId});
  @override
  List<Object?> get props => [showingId, requesterId];
}

class PropertyState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<PropertyDataClass> allProperties;
  final List<PropertyDataClass> filteredProperties;
  final List<Map<String, dynamic>> favorites;
  final List<Map<String, dynamic>> savedSearches;
  final List<Map<String, dynamic>> showings;
  final bool isFilterActive;

  const PropertyState(
      {this.isLoading = false,
      this.error,
      this.allProperties = const [],
      this.filteredProperties = const [],
      this.favorites = const [],
      this.savedSearches = const [],
      this.showings = const [],
      this.isFilterActive = false});

  PropertyState copyWith(
      {bool? isLoading,
      String? error,
      List<PropertyDataClass>? allProperties,
      List<PropertyDataClass>? filteredProperties,
      List<Map<String, dynamic>>? favorites,
      List<Map<String, dynamic>>? savedSearches,
      List<Map<String, dynamic>>? showings,
      bool? isFilterActive}) {
    return PropertyState(
        isLoading: isLoading ?? this.isLoading,
        error: error,
        allProperties: allProperties ?? this.allProperties,
        filteredProperties: filteredProperties ?? this.filteredProperties,
        favorites: favorites ?? this.favorites,
        savedSearches: savedSearches ?? this.savedSearches,
        showings: showings ?? this.showings,
        isFilterActive: isFilterActive ?? this.isFilterActive);
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        allProperties,
        filteredProperties,
        favorites,
        savedSearches,
        showings,
        isFilterActive
      ];
}

@injectable
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;

  PropertyBloc(this._repository) : super(const PropertyState()) {
    on<LoadProperties>(_onLoad);
    on<LoadPropertiesByZip>(_onLoadByZip);
    on<ApplyFilter>(_onApplyFilter);
    on<ClearFilter>(_onClearFilter);
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<LoadSavedSearches>(_onLoadSavedSearches);
    on<SaveSearch>(_onSaveSearch);
    on<DeleteSavedSearch>(_onDeleteSavedSearch);
    on<LoadShowings>(_onLoadShowings);
    on<CreateShowing>(_onCreateShowing);
    on<CancelShowing>(_onCancelShowing);
  }

  Future<void> _onLoad(
      LoadProperties event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getAllProperties(
        requesterId: event.requesterId,
        zipCode: event.zipCode,
        city: event.city,
        state: event.state,
        homeType: event.homeType,
        statusType: event.statusType,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        minBeds: event.minBeds,
        maxBeds: event.maxBeds);
    r.fold((f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (props) {
      final hasFilters = _hasAnyFilters(event);
      final filtered = hasFilters
          ? _repository.filterProperties(
              properties: props,
              minPrice: event.minPrice,
              maxPrice: event.maxPrice,
              minBeds: event.minBeds,
              maxBeds: event.maxBeds,
              minBaths: event.minBaths,
              maxBaths: event.maxBaths,
              minSquareFeet: event.minSquareFeet,
              maxSquareFeet: event.maxSquareFeet,
              minYearBuilt: event.minYearBuilt,
              maxYearBuilt: event.maxYearBuilt,
              homeTypes: event.homeTypes,
            )
          : props;

      emit(state.copyWith(
        isLoading: false,
        allProperties: props,
        filteredProperties: filtered,
        isFilterActive: hasFilters,
      ));
    });
  }

  bool _hasAnyFilters(LoadProperties event) {
    return event.minPrice != null ||
        event.maxPrice != null ||
        event.minBeds != null ||
        event.maxBeds != null ||
        event.minBaths != null ||
        event.maxBaths != null ||
        event.minSquareFeet != null ||
        event.maxSquareFeet != null ||
        event.minYearBuilt != null ||
        event.maxYearBuilt != null ||
        (event.homeTypes != null && event.homeTypes!.isNotEmpty);
  }

  Future<void> _onLoadByZip(
      LoadPropertiesByZip event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final r = await _repository.getPropertiesByZipId(
        zpId: event.zipId, requesterId: event.requesterId);
    r.fold(
        (f) => emit(state.copyWith(isLoading: false, error: f.message)),
        (props) => emit(state.copyWith(
            isLoading: false,
            allProperties: props,
            filteredProperties: props,
            isFilterActive: false)));
  }

  void _onApplyFilter(ApplyFilter event, Emitter<PropertyState> emit) {
    final filtered = _repository.filterProperties(
        properties: state.allProperties,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        minBeds: event.minBeds,
        maxBeds: event.maxBeds,
        minBaths: event.minBaths,
        maxBaths: event.maxBaths,
        minSquareFeet: event.minSquareFeet,
        maxSquareFeet: event.maxSquareFeet,
        minYearBuilt: event.minYearBuilt,
        maxYearBuilt: event.maxYearBuilt,
        homeTypes: event.homeTypes);
    emit(state.copyWith(filteredProperties: filtered, isFilterActive: true));
  }

  void _onClearFilter(ClearFilter event, Emitter<PropertyState> emit) {
    emit(state.copyWith(
        filteredProperties: state.allProperties, isFilterActive: false));
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<PropertyState> emit) async {
    final r = await _repository.getFavorites(
        userId: event.userId, requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)),
        (fav) => emit(state.copyWith(favorites: fav)));
  }

  Future<void> _onAddFavorite(
      AddFavorite event, Emitter<PropertyState> emit) async {
    final r = await _repository.addFavorite(
        userId: event.userId,
        propertyId: event.propertyId,
        requesterId: event.requesterId);
    r.fold(
        (f) => emit(state.copyWith(error: f.message)),
        (_) => add(LoadFavorites(
            userId: event.userId, requesterId: event.requesterId)));
  }

  Future<void> _onRemoveFavorite(
      RemoveFavorite event, Emitter<PropertyState> emit) async {
    final r = await _repository.removeFavorite(
        userId: event.userId,
        propertyId: event.favoriteId,
        requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)), (_) {
      final u =
          state.favorites.where((f) => f['id'] != event.favoriteId).toList();
      emit(state.copyWith(favorites: u));
    });
  }

  Future<void> _onLoadSavedSearches(
      LoadSavedSearches event, Emitter<PropertyState> emit) async {
    final r = await _repository.getSavedSearches(
        userId: event.userId, requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)),
        (ss) => emit(state.copyWith(savedSearches: ss)));
  }

  Future<void> _onSaveSearch(
      SaveSearch event, Emitter<PropertyState> emit) async {
    final r = await _repository.saveSearch(
        userId: event.userId,
        inputField: event.searchData['input_field'] ?? '',
        propertyFilter: event.searchData,
        requesterId: event.requesterId);
    r.fold(
        (f) => emit(state.copyWith(error: f.message)),
        (_) => add(LoadSavedSearches(
            userId: event.userId, requesterId: event.requesterId)));
  }

  Future<void> _onDeleteSavedSearch(
      DeleteSavedSearch event, Emitter<PropertyState> emit) async {
    final r = await _repository.deleteSavedSearch(
        searchId: event.searchId, requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)), (_) {
      final u =
          state.savedSearches.where((s) => s['id'] != event.searchId).toList();
      emit(state.copyWith(savedSearches: u));
    });
  }

  Future<void> _onLoadShowings(
      LoadShowings event, Emitter<PropertyState> emit) async {
    final r = await _repository.getShowings(
        userId: event.userId, requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)),
        (sh) => emit(state.copyWith(showings: sh)));
  }

  Future<void> _onCreateShowing(
      CreateShowing event, Emitter<PropertyState> emit) async {
    final r = await _repository
        .createShowing(requesterId: event.requesterId, showingData: {
      'user_id': event.userId,
      'property_id': event.propertyId,
      'date': event.date,
      'time': event.time
    });
    r.fold(
        (f) => emit(state.copyWith(error: f.message)),
        (_) => add(LoadShowings(
            userId: event.userId, requesterId: event.requesterId)));
  }

  Future<void> _onCancelShowing(
      CancelShowing event, Emitter<PropertyState> emit) async {
    final r = await _repository.cancelShowing(
        showingId: event.showingId, requesterId: event.requesterId);
    r.fold((f) => emit(state.copyWith(error: f.message)), (_) {
      final u =
          state.showings.where((s) => s['id'] != event.showingId).toList();
      emit(state.copyWith(showings: u));
    });
  }
}
