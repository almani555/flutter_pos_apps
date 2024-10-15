import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_datasource.dart';
import 'package:flutter_pos_apps/presentation/order/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const HistoryState.loading());
      final data = await ProductLocalDatasource.instance.getAllOrder();
      emit(HistoryState.success(data));
    });
  }
}
