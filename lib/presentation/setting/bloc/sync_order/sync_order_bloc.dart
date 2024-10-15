// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_apps/data/datasources/order_remote_datasource.dart';
import 'package:flutter_pos_apps/data/models/request/order_request_model.dart';

part 'sync_order_bloc.freezed.dart';
part 'sync_order_event.dart';
part 'sync_order_state.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  SyncOrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SendOrder>((event, emit) async {
      emit(const SyncOrderState.loading());
      //get order from local is sync is 0
      final ordersIsSyncZero =
          await ProductLocalDatasource.instance.getOrderByIsSync();
      for (final order in ordersIsSyncZero) {
        final orderItems = await ProductLocalDatasource.instance
            .getOrderItemByOrderIdLocal(order.id!);
        final orderRequest = OrderRequestModel(
            transactionTime: order.transactionTime,
            totalItem: order.totalQuantity,
            totalPrice: order.totalPrice,
            kasirId: order.idKasir,
            paymentMethod: order.paymentMethod,
            orderItems: orderItems
            // .map((e) => OrderItemModel(
            //       productId: e.productId,
            //       quantity: e.quantity,
            //       totalPrice: e.totalPrice,
            //     ))
            // .toList(),
            );
        final response = await orderRemoteDatasource.sendOrder(orderRequest);
        if (response) {
          await ProductLocalDatasource.instance
              .updateIsSyncOrderById(order.id!);
        }
      }
      emit(const SyncOrderState.success());
      // if (response) {
      //   emit(const SyncOrderState.success());
      // } else {
      //   emit(const SyncOrderState.error('Failed to send order'));
      // }
    });
  }
}
