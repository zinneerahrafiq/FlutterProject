import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pro/blocs/category/category_bloc.dart';
import 'package:flutter_application_pro/blocs/product/product_bloc.dart';
import 'package:flutter_application_pro/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_application_pro/config/app_router.dart';
import 'package:flutter_application_pro/config/theme.dart';
import 'package:flutter_application_pro/models/wishlist_model.dart';
import 'package:flutter_application_pro/repositories/category/category_repository.dart';
import 'package:flutter_application_pro/repositories/products/product_repository.dart';
import 'package:flutter_application_pro/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/cart/cart_event.dart';
import 'widgets/appbar.dart';
import 'widgets/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
            create: (_) => CategoryBloc(
                  categoryRepository: CategoryRepository(),
                )..add(LoadCategories())),
        BlocProvider(
            create: (_) => ProductBloc(
                  productRepository: ProductRepository(),
                )..add(LoadProducts()))

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
