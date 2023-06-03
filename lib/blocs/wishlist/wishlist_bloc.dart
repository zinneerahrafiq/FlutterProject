// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

// import '../../models/models.dart';

// part 'wishlist_event.dart';
// part 'wishlist_state.dart';

// class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
//   WishlistBloc() : super(WishlistLoading());

//   @override
//   Stream<WishlistState> mapEventToState(
//     WishlistEvent event,
//   ) async* {
//     if (event is StartWishlist) {
//       yield* _mapStartWishListToState();
//     } else if (event is AddWishListProduct) {
//       yield* _mapAddWishListProductToState(event, state);
//     } else if (event is RemoveWishListProduct) {
//       yield* _mapRemoveWishListProductToState(event, state);
//     }
//   }

//   Stream<WishlistState> _mapStartWishListToState() async* {
//     yield WishlistLoading();
//     try {
//       await Future<void>.delayed(Duration(seconds: 1));
//       yield const WishlistLoaded();
//     } catch (_) {}
//   }

//   Stream<WishlistState> _mapAddWishListProductToState(
//     AddWishListProduct event,
//     WishlistState state,
//   ) async* {
//     if (state is WishlistLoaded) {
//       try {
//         yield WishlistLoaded(
//             wishlist: Wishlist(
//                 products: List.from(state.wishlist.products)
//                   ..add(event.product)));
//       } catch (_) {}
//     }
//   }

//   Stream<WishlistState> _mapRemoveWishListProductToState(
//     RemoveWishListProduct event,
//     WishlistState state,
//   ) async* {
//     if (state is WishlistLoaded) {
//       try {
//         yield WishlistLoaded(
//             wishlist: Wishlist(
//                 products: List.from(state.wishlist.products)
//                   ..remove(event.product)));
//       } catch (_) {}
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';
import '../../models/wishlist_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<WishlistEvent>((event, emit) {});

    on<StartWishlist>((event, emit) async {
      emit(WishlistLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(const WishlistLoaded());
      } catch (_) {}
    });

    on<AddWishListProduct>((event, Emitter<WishlistState> emit) {
      final state = this.state;
      if (state is WishlistLoaded) {
        try {
          emit(WishlistLoaded(
              wishlist: Wishlist(
                  products: List.from(state.wishlist.products)
                    ..add(event.product))));
        } catch (_) {}
      }
    });

    on<RemoveWishListProduct>((event, Emitter<WishlistState> emit) {
      final state = this.state;
      if (state is WishlistLoaded) {
        try {
          emit(WishlistLoaded(
              wishlist: Wishlist(
                  products: List.from(state.wishlist.products)
                    ..remove(event.product))));
        } catch (_) {}
      }
    });
  }
}
