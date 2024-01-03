import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app_fic/bloc/Products/products_bloc.dart';
import 'package:seller_app_fic/bloc/Register/register_bloc.dart';
import 'package:seller_app_fic/bloc/category/category_bloc.dart';
import 'package:seller_app_fic/pages/Dashboard/seller_dashboard.dart';
import 'package:seller_app_fic/pages/auth/auth_page.dart';
import 'package:seller_app_fic/utilis/light_themes.dart';
import 'bloc/Login/login_bloc.dart';
import 'bloc/Logout/logout_bloc.dart';
import 'data/DataResources/auth_local_datasources.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return const SellerDashboard();
              } else {
                return const AuthPage();
              }
            },
          )),
    );
  }
}