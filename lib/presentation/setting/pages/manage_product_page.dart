import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/assets/assets.gen.dart';
import 'package:flutter_pos_apps/core/components/spaces.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/models/product_category.dart';
import 'package:flutter_pos_apps/presentation/home/models/product_model.dart';
import 'package:flutter_pos_apps/presentation/setting/pages/add_product_page.dart';
import 'package:flutter_pos_apps/presentation/setting/widgets/menu_product_item.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final List<ProductModel> products = [
    ProductModel(
      image: Assets.images.f1.path,
      name: 'Vanila Late Vanila itu',
      category: ProductCategory.drink,
      price: 20000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f2.path,
      name: 'Vanila Late Vanila itu',
      category: ProductCategory.drink,
      price: 20000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f3.path,
      name: 'Vanila Late Vanila itu',
      category: ProductCategory.drink,
      price: 20000,
      stock: 10,
    ),
    ProductModel(
      image: Assets.images.f4.path,
      name: 'Vanila Late Vanila itu',
      category: ProductCategory.drink,
      price: 20000,
      stock: 10,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'List Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, success: (products) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SpaceHeight(20.0),
                  itemBuilder: (context, index) => MenuProductItem(
                    data: products[index],
                  ),
                );
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
