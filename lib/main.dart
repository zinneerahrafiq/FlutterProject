import 'package:flutter/material.dart';
import 'package:flutter_application_pro/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_application_pro/config/app_router.dart';
import 'package:flutter_application_pro/config/theme.dart';
import 'package:flutter_application_pro/models/wishlist_model.dart';
import 'package:flutter_application_pro/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/appbar.dart';
import 'widgets/navbar.dart';

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
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlist()))
        //create: (context) => WishlistBloc(),
      ],
      child: MaterialApp(
        title: 'Thrift App',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
        //home: HomeScreen()
      ),
    );
  }
}
