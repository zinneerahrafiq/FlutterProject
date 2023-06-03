part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishlist extends WishlistEvent {}

class AddWishListProduct extends WishlistEvent {
  final Product product;

  const AddWishListProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveWishListProduct extends WishlistEvent {
  final Product product;

  const RemoveWishListProduct(this.product);

  @override
  List<Object> get props => [product];
}
