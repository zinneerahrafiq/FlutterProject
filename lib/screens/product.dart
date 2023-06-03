import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pro/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_application_pro/widgets/herocarouselcard.dart';
import 'package:flutter_application_pro/widgets/navbar.dart';
import 'package:flutter_application_pro/widgets/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_model.dart';

class productScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
        builder: (_) => productScreen(
              product: product,
            ),
        settings: RouteSettings(name: routeName));
  }

  final Product product;

  const productScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: product.name),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      )),
                  BlocBuilder<WishlistBloc, WishlistState>(
                      builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context
                              .read<WishlistBloc>()
                              .add(AddWishListProduct(product));

                          final snackbar =
                              SnackBar(content: Text('Added to your wishlist'));

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ));
                  }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: () {},
                      child: Text('ADD TO CART',
                          style: Theme.of(context).textTheme.headline3!))
                ]),
          ),
        ),
        body: ListView(children: [
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: [
                HeroCarouselCard(
                  product: product,
                )
              ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Product Information",
                  style: Theme.of(context).textTheme.headline3,
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Lorem ispum  ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Delivery Information",
                  style: Theme.of(context).textTheme.headline3,
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            ]),
          )
        ])

        // HeroCarouselCard(product: product),
        );
  }
}
