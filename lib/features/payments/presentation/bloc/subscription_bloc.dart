import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../data/services/subscription_service.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
  @override List<Object?> get props => [];
}

class InitSubscription extends SubscriptionEvent {
  final String userId;
  const InitSubscription(this.userId);
  @override List<Object?> get props => [userId];
}

class CheckSubscriptionStatus extends SubscriptionEvent {}

class LoadOfferings extends SubscriptionEvent {}

class PurchasePackage extends SubscriptionEvent {
  final Package package;
  const PurchasePackage(this.package);
  @override List<Object?> get props => [package];
}

class RestorePurchases extends SubscriptionEvent {}

class _CustomerInfoUpdated extends SubscriptionEvent {
  final CustomerInfo info;
  const _CustomerInfoUpdated(this.info);
  @override List<Object?> get props => [info];
}

class SubscriptionState extends Equatable {
  final bool isLoading, isActive, isPurchasing;
  final String? error, successMessage;
  final Offerings? offerings;
  final CustomerInfo? customerInfo;

  const SubscriptionState({this.isLoading = false, this.isActive = false, this.isPurchasing = false, this.error, this.successMessage, this.offerings, this.customerInfo});

  SubscriptionState copyWith({bool? isLoading, bool? isActive, bool? isPurchasing, String? error, String? successMessage, Offerings? offerings, CustomerInfo? customerInfo}) {
    return SubscriptionState(isLoading: isLoading ?? this.isLoading, isActive: isActive ?? this.isActive, isPurchasing: isPurchasing ?? this.isPurchasing, error: error, successMessage: successMessage, offerings: offerings ?? this.offerings, customerInfo: customerInfo ?? this.customerInfo);
  }

  @override List<Object?> get props => [isLoading, isActive, isPurchasing, error, successMessage, offerings, customerInfo];
}

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionService _service;
  StreamSubscription<CustomerInfo>? _sub;

  SubscriptionBloc(this._service) : super(const SubscriptionState()) {
    on<InitSubscription>(_onInit);
    on<CheckSubscriptionStatus>(_onCheck);
    on<LoadOfferings>(_onLoadOfferings);
    on<PurchasePackage>(_onPurchase);
    on<RestorePurchases>(_onRestore);
    on<_CustomerInfoUpdated>(_onCustomerInfo);
  }

  Future<void> _onInit(InitSubscription e, Emitter<SubscriptionState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _service.initialize();
      await _service.loginUser(e.userId);
      final active = await _service.hasActiveSubscription();
      emit(state.copyWith(isLoading: false, isActive: active));
      await _sub?.cancel();
      _sub = _service.customerInfoStream.listen((info) => add(_CustomerInfoUpdated(info)));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCheck(CheckSubscriptionStatus e, Emitter<SubscriptionState> emit) async {
    final active = await _service.hasActiveSubscription();
    emit(state.copyWith(isActive: active));
  }

  Future<void> _onLoadOfferings(LoadOfferings e, Emitter<SubscriptionState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final offerings = await _service.getOfferings();
      emit(state.copyWith(isLoading: false, offerings: offerings));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onPurchase(PurchasePackage e, Emitter<SubscriptionState> emit) async {
    emit(state.copyWith(isPurchasing: true, error: null));
    try {
      final info = await _service.purchasePackage(e.package);
      final active = info.entitlements.active.isNotEmpty;
      emit(state.copyWith(isPurchasing: false, isActive: active, customerInfo: info, successMessage: 'Subscription activated!'));
    } catch (e) {
      emit(state.copyWith(isPurchasing: false, error: e.toString()));
    }
  }

  Future<void> _onRestore(RestorePurchases e, Emitter<SubscriptionState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final info = await _service.restorePurchases();
      final active = info.entitlements.active.isNotEmpty;
      emit(state.copyWith(isLoading: false, isActive: active, customerInfo: info, successMessage: active ? 'Purchases restored!' : 'No active subscriptions found'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onCustomerInfo(_CustomerInfoUpdated e, Emitter<SubscriptionState> emit) {
    final active = e.info.entitlements.active.isNotEmpty;
    emit(state.copyWith(isActive: active, customerInfo: e.info));
  }

  @override
  Future<void> close() { _sub?.cancel(); return super.close(); }
}