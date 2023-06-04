import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pro/blocs/cart/cart_state.dart';
import 'package:flutter_application_pro/blocs/product/product_bloc.dart';
import 'package:flutter_application_pro/models/category_model.dart';
import 'package:flutter_application_pro/models/product_model.dart';
import 'package:flutter_application_pro/screens/product.dart';
import 'package:flutter_application_pro/widgets/herocarouselcard.dart';
import 'package:flutter_application_pro/widgets/navbar.dart';
import 'package:flutter_application_pro/widgets/appbar.dart';
import 'package:flutter_application_pro/widgets/section_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/category/category_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/product_carousel.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> imgList = [
    //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    // ];

    return Scaffold(
        appBar: CustomAppBar(title: "THRIFT"),
        bottomNavigationBar: navbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                    ),
                    items: state.categories
                        .map((category) => HeroCarouselCard(category: category))
                        .toList(),
                  );
                } else {
                  return Text("something went wrong");
                }
              }),

              SectionTitle(title: "recommended"),
              //ProductCard(product: Product.products[0]),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products: state.products
                            .where((product) => product.isRecommended)
                            .toList());
                  } else {
                    return Text("something went wrong");
                  }
                },
              ),

              SectionTitle(title: "most popular"),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products: state.products
                            .where((product) => product.isPopular)
                            .toList());
                  } else {
                    return Text("something went wrong");
                  }
                },
              ),
            ],
          ),
        ));
  }
}
