import 'package:flutter/material.dart';
import 'package:flutter_application_pro/models/category_model.dart';
import 'package:flutter_application_pro/models/product_model.dart';
import 'package:flutter_application_pro/screens/cart.dart';
import 'package:flutter_application_pro/screens/catalog.dart';
import 'package:flutter_application_pro/screens/home.dart';
import 'package:flutter_application_pro/screens/wishlist.dart';
import 'package:flutter_application_pro/screens/product.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('this is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      // case SplashScreen.routeName:
      //   return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case productScreen.routeName:
        return productScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
            ));
  }
}
