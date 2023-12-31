import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/assets/assets.gen.dart';
import 'package:flutter_pos_apps/core/components/menu_button.dart';
import 'package:flutter_pos_apps/core/components/spaces.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/models/order_item.dart';
import 'package:flutter_pos_apps/presentation/order/models/order_model.dart';
import 'package:flutter_pos_apps/presentation/order/widgets/order_card.dart';
import 'package:flutter_pos_apps/presentation/order/widgets/payment_cash_dialog.dart';
import 'package:flutter_pos_apps/presentation/order/widgets/payment_qris_dialog.dart';
import 'package:flutter_pos_apps/presentation/order/widgets/process_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final indexValue = ValueNotifier(0);
  // final List<OrderModel> orders = [
  //   OrderModel(
  //     image: Assets.images.f1.path,
  //     name: 'Nutty Oat Latte',
  //     price: 39000,
  //   ),
  //   OrderModel(
  //     image: Assets.images.f2.path,
  //     name: 'Iced Latte',
  //     price: 24000,
  //   ),
  // ];
  // List<OrderItem> orders = [];

  // int calculateTotalPrice(List<OrderItem> orders) {
  //   return orders.fold(
  //       0,
  //       (previousValue, element) =>
  //           previousValue + element.product.price * element.quantity);
  // }
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.delete.svg(),
          ),
        ],
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: Text('No Data'),
            );
          }, success: (data, qty, price) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }
            totalPrice = price;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SpaceHeight(20.0),
              itemBuilder: (context, index) => OrderCard(
                padding: paddingHorizontal,
                data: data[index],
                onDeleteTap: () {
                  // orders.removeAt(index);
                  // setState(() {});
                },
              ),
            );
          });
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: indexValue,
              builder: (context, value, _) => Row(
                children: [
                  const SpaceWidth(10.0),
                  MenuButton(
                    iconPath: Assets.icons.cash.path,
                    label: 'Tunai',
                    isActive: value == 1,
                    onPressed: () => indexValue.value = 1,
                  ),
                  const SpaceWidth(10.0),
                  MenuButton(
                    iconPath: Assets.icons.qrCode.path,
                    label: 'QRIS',
                    isActive: value == 2,
                    onPressed: () => indexValue.value = 2,
                  ),
                  const SpaceWidth(10.0),
                ],
              ),
            ),
            const SpaceHeight(20.0),
            ProcessButton(
              price: 20,
              onPressed: () async {
                if (indexValue.value == 0) {
                } else if (indexValue.value == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => PaymentCashDialog(
                      price: totalPrice,
                    ),
                  );
                } else if (indexValue.value == 2) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const PaymentQrisDialog(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
