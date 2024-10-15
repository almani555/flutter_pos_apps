import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos_apps/presentation/home/models/order_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Success([], 0, 0, '', 0, 0, '')) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(const _Loading());
      final userData = await AuthLocalDatasource().getAuthData();
      emit(_Success(
          event.orders,
          event.orders.fold(
              0, (previousValue, element) => previousValue + element.quantity),
          event.orders.fold(
              0,
              (previousValue, element) =>
                  previousValue + element.product.price * element.quantity),
          event.paymentMethod,
          0,
          userData.user.id,
          userData.user.name));
    });

    on<_AddNominalBayar>((event, emit) {
      var currentState = state as _Success;
      emit(const _Loading());
      emit(_Success(
        currentState.products,
        currentState.totalQuantity,
        currentState.totalPrice,
        currentState.paymentMethod,
        event.nominal,
        currentState.idKasir,
        currentState.namaKasir,
      ));
    });

    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([], 0, 0, '', 0, 0, ''));
    });
  }
}
