part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetProducts extends ProductEvent {
  GetProducts();
}

class GetRecommendProducts extends ProductEvent {
  GetRecommendProducts();
}

class AdjustAmount extends ProductEvent {
  AdjustAmount({required this.item, required this.symbol});
  final Item item;
  final String symbol;
}

class CheckoutEvent extends ProductEvent {
  CheckoutEvent();
}
