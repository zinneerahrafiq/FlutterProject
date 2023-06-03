import 'package:flutter/material.dart';
import 'package:flutter_application_pro/widgets/navbar.dart';
import 'package:flutter_application_pro/widgets/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/wishlist/wishlist_bloc.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => WishlistScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    var categoryProducts;
    return Scaffold(
        appBar: CustomAppBar(title: "Wishlist"),
        bottomNavigationBar: navbar(),
        body:
            BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
          if (state is WishlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishlistLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.4,
              ),
              itemCount: state.wishlist.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: ProductCard(
                  product: state.wishlist.products[index],
                  widthFactor: 1.1,
                  leftPosition: 100,
                  isWishlist: true,
                )

                    // child: ProductCard.catalog(
                    //   product: Product.products[index],
                    //   widthFactor: 1.1,
                    // ),
                    );
              },
            );
          } else {
            return Text('something went wrong');
          }
        }));
  }
}
