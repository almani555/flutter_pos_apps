// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_apps/data/datasources/product_remote_datasource.dart';
import 'package:flutter_pos_apps/data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  List<Product> products = [];
  ProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemoteDatasource.getProducts();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    on<_FetchLocal>((event, emit) async {
      emit(const ProductState.loading());
      final localProducts =
          await ProductLocalDatasource.instance.getAllProduct();
      products = localProducts;
      emit(ProductState.success(products));
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());
      final newProducts = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();
      emit(ProductState.success(newProducts));
    });
  }
}
