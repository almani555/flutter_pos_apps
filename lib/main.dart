import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/constants/colors.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/midtrans_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/order_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/product_remote_datasource.dart';
import 'package:flutter_pos_apps/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_pos_apps/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos_apps/presentation/history/bloc/history/history_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_pos_apps/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_pos_apps/presentation/order/bloc/order/order_bloc.dart';
import 'package:flutter_pos_apps/presentation/order/bloc/qris/qris_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource())
            ..add(const ProductEvent.fetchLocal()),
        ),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => QrisBloc(MidtransRemoteDatasource())),
        BlocProvider(create: (context) => HistoryBloc()),
        BlocProvider(
            create: (context) => SyncOrderBloc(OrderRemoteDatasource())),
      ],
      child: MaterialApp(
        title: 'POS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const DashboardPage();
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }
}
