import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/assets/assets.gen.dart';
import 'package:flutter_pos_apps/core/components/menu_button.dart';
import 'package:flutter_pos_apps/core/components/spaces.dart';
import 'package:flutter_pos_apps/core/constants/colors.dart';
import 'package:flutter_pos_apps/core/extensions/build_context_ext.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_datasource.dart';
import 'package:flutter_pos_apps/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_pos_apps/presentation/order/models/order_model.dart';
import 'package:flutter_pos_apps/presentation/setting/pages/manage_printer_page.dart';
import 'package:flutter_pos_apps/presentation/setting/pages/manage_product_page.dart';
import 'package:flutter_pos_apps/presentation/setting/pages/server_key_page.dart';
import 'package:flutter_pos_apps/presentation/setting/pages/sync_data_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kelola Aplikasi',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageProduct.path,
                  label: 'Kelola Produk',
                  onPressed: () => context.push(const ManageProductPage()),
                  isImage: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.images.managePrinter.path,
                  label: 'Kelola Printer',
                  onPressed: () => context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
            const SpaceHeight(20),
            Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageApi.path,
                  label: 'QRIS Server Key',
                  onPressed: () => context.push(const ServerKeyPage()),
                  isImage: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.images.managePrinterx.path,
                  label: 'Singkronisasi Data',
                  onPressed: () => context.push(const SyncDataPage()),
                  isImage: true,
                ),
              ],
            ),
            const SpaceHeight(30),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocalDatasource().removeAuthData();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'),
                );
              },
            ),
          ],
        ));
  }
}
