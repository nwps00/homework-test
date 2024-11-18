part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loadingItem,
  loadedItem,
  loadingRecommend,
  loadedRecommend,
  loadingCheckout,
  loadedCheckout,
  error,
  errorRecommend,
  added
}

class ProductState {
  final ProductStatus status;
  final int? num;
  final Items? items;
  final List<Item>? recommendItems;
  final List<Item>? selectedItem;
  final double? totalPrice;
  final double? subtotal;
  final double? discount;
  final bool? isFail;

  ProductState(
      {this.status = ProductStatus.initial,
      this.num,
      this.items,
      this.recommendItems,
      this.selectedItem,
      this.totalPrice,
      this.subtotal,
      this.discount,
      this.isFail});

  ProductState copyWith(
      {ProductStatus? status,
      int? num,
      Items? items,
      List<Item>? recommendItems,
      List<Item>? selectedItem,
      double? subtotal,
      double? totalPrice,
      double? discount,
      bool? isFail}) {
    return ProductState(
        status: status ?? this.status,
        num: num ?? this.num,
        items: items ?? this.items,
        recommendItems: recommendItems ?? this.recommendItems,
        selectedItem: selectedItem ?? this.selectedItem,
        totalPrice: totalPrice ?? this.totalPrice,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        isFail: isFail ?? this.isFail);
  }
}
