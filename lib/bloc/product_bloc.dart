import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/model/items_model.dart';
import 'package:market_app/service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productsRepository;

  ProductBloc({required this.productsRepository}) : super(ProductState()) {
    on<GetProducts>(_mapGetProductsEventToState);
    on<GetRecommendProducts>(_mapGetRecommendEventToState);
    on<AdjustAmount>(_mapAdjustAmountEventToState);
    on<CheckoutEvent>(_mapCheckoutEventToState);
  }

  void _mapGetProductsEventToState(
      GetProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingItem));
    final Items products = await ProductService.getProducts();
    emit(state.copyWith(
      status: ProductStatus.loadedItem,
      items: products,
    ));
  }

  void _mapGetRecommendEventToState(
      GetRecommendProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingRecommend));
    final List<Item> products = await ProductService.getRecommend();
    emit(state.copyWith(
      status: ProductStatus.loadedRecommend,
      recommendItems: products,
    ));
  }

  void _mapAdjustAmountEventToState(
      AdjustAmount event, Emitter<ProductState> emit) async {
    List<Item> selectList = List.from(state.selectedItem ?? []);

    bool containsItem = selectList
        .any((i) => i.name == event.item.name && i.price == event.item.price);

    double totalPrice = 0;
    double subTotal = 0;
    double discount = 0;

    if (containsItem) {
      Item existingItem = selectList.firstWhere(
          (i) => i.name == event.item.name && i.price == event.item.price);
      existingItem = existingItem.copyWith(
          amount: event.symbol == '+'
              ? existingItem.amount! + 1
              : event.symbol == '--'
                  ? 0
                  : existingItem.amount! - 1);

      if (existingItem.amount == 0) {
        selectList.removeWhere((test) =>
            test.name == existingItem.name && test.price == existingItem.price);
      } else {
        selectList[selectList.indexOf(existingItem)] = existingItem;
      }
    } else {
      Item newItem = event.item.copyWith(amount: 1);
      selectList.add(newItem);
    }

    for (var item in selectList) {
      double itemPrice = item.price ?? 0;
      double itemAmount = item.amount?.toDouble() ?? 0;
      subTotal += itemPrice * itemAmount;
      int completePairs = (itemAmount / 2).floor();
      double itemTotalPrice = 0;
      if (completePairs > 0) {
        double pairPrice = itemPrice * 2;
        double discountedPrice = pairPrice * (1 - 0.05);
        itemTotalPrice += discountedPrice * completePairs;
      }
      int remainingUnits = (itemAmount % 2).toInt();
      if (remainingUnits > 0) {
        itemTotalPrice += itemPrice * remainingUnits;
      }
      totalPrice += itemTotalPrice;
    }
    discount = subTotal - totalPrice;
    emit(
      state.copyWith(
        status: ProductStatus.added,
        selectedItem: selectList,
        totalPrice: totalPrice,
        discount: discount,
        subtotal: subTotal,
        isFail: null,
      ),
    );
  }

  void _mapCheckoutEventToState(
      CheckoutEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingCheckout));
    final bool res = await ProductService.postCheckout();
    emit(
      state.copyWith(
          status: ProductStatus.loadedCheckout,
          isFail: res,
          selectedItem: res ? state.selectedItem : []),
    );
  }
}
