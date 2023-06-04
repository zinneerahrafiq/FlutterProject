import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';
import '../../repositories/products/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState();
    }
    if (event is UpdateProducts) {
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepository
        .getAllProducts()
        .listen((products) => add(UpdateProducts(products)));
  }

  Stream<ProductState> _mapUpdateProductsToState(UpdateProducts event) async* {
    yield ProductLoaded(products: event.products);
  }
}



// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository _ProductRepository;
//   StreamSubscription? _ProductSubscription;

//   ProductBloc({required ProductRepository ProductRepository})
//       : _ProductRepository = ProductRepository,
//         super(ProductLoading()) {
//     on<LoadProducts>(_onLoadProducts);
//     on<UpdateProducts>(_onUpdateProducts);
//   }

//   void _onLoadProducts(
//     LoadProducts event,
//     Emitter<ProductState> emit,
//   ) {
//     _ProductSubscription?.cancel();
//     _ProductSubscription = _ProductRepository.getAllProducts().listen(
//           (products) => add(
//             UpdateProducts(products),
//           ),
//         );
//   }

//   void _onUpdateProducts(
//     UpdateProducts event,
//     Emitter<ProductState> emit,
//   ) {
//     emit(
//       ProductLoaded(Products: event.Products),
//     );
//   }
// }



// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository _productRepository;
//   StreamSubscription? _productSubscription;

//   ProductBloc({required ProductRepository productRepository})
//       : _productRepository = productRepository,
//         super(ProductLoading()) {
//     on<LoadProducts>(_onLoadProducts);
//     on<UpdateProducts>(_onUpdateProducts);
//   }

//   void _onLoadProducts(
//     LoadProducts event,
//     Emitter<ProductState> emit,
//   ) {
//     _productSubscription?.cancel();
//     _productSubscription = _productRepository.getAllProducts().listen(
//           (products) => add(
//             UpdateProducts(products),
//           ),
//         );
//   }

//   void _onUpdateProducts(
//     UpdateProducts event,
//     Emitter<ProductState> emit,
//   ) {
//     emit(ProductLoaded(products: event.products));
//   }
// }
