import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_app/bloc/product_bloc.dart';
import 'package:market_app/model/items_model.dart';
import 'package:market_app/screen/landing_page.dart';
import 'package:market_app/style/color_theme.dart';
import 'package:market_app/style/font_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class FirstView extends StatefulWidget {
  const FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView>
{
  final formatter = NumberFormat('#,##0.00');

  @override
  void initState() {
    context.read<ProductBloc>().add(GetRecommendProducts());
    context.read<ProductBloc>().add(GetProducts());
    super.initState();
  }

  String isSelectedTab(int index, int selectedIndex) {
    return index == selectedIndex
        ? 'assets/icons/selected_star.svg'
        : 'assets/icons/unselected_star.svg';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.status == ProductStatus.loadedCheckout) {
          // show snack bar if check out fail
          if (state.isFail == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong.'),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: ColorTheme.surface,
              body:
                  const LandingPage(),
                  // Scaffold(
                  //   appBar: AppBar(
                  //     leading: GestureDetector(
                  //       onTap: () {
                  //       },
                  //       child: Icon(
                  //         Icons.arrow_back,
                  //       ),
                  //     ),
                  //     title: Text(
                  //       'Cart',
                  //       style: FontTheme.titleLarge,
                  //     ),
                  //   ),
                  //   body: state.isFail == false &&
                  //           state.status == ProductStatus.loadedCheckout
                  //       ?
                  //       // check out success
                  //       Center(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 'Success!',
                  //                 style: FontTheme.titleLarge
                  //                     .copyWith(color: ColorTheme.primary),
                  //               ),
                  //               SizedBox(
                  //                 height: 1.h,
                  //               ),
                  //               Text(
                  //                 'Thank you for shopping with us!',
                  //                 style: FontTheme.titleSmall,
                  //               ),
                  //               SizedBox(
                  //                 height: 1.h,
                  //               ),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                 },
                  //                 child: Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: 16, vertical: 8),
                  //                   decoration: BoxDecoration(
                  //                     color: ColorTheme.primary,
                  //                     borderRadius: BorderRadius.circular(100),
                  //                   ),
                  //                   child: Text(
                  //                     'Shop again',
                  //                     style: FontTheme.labelLarge.copyWith(
                  //                         color: ColorTheme.onPrimary),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       : state.selectedItem == null ||
                  //               state.selectedItem?.length == 0
                  //           ?
                  //           // empty cart
                  //           Center(
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     'Empty cart',
                  //                     style: FontTheme.titleLarge,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 1.h,
                  //                   ),
                  //                   GestureDetector(
                  //                     onTap: () {
                  //                       tabController.animateTo(0);
                  //                     },
                  //                     child: Container(
                  //                       padding: EdgeInsets.symmetric(
                  //                           horizontal: 16, vertical: 8),
                  //                       decoration: BoxDecoration(
                  //                         color: ColorTheme.primary,
                  //                         borderRadius:
                  //                             BorderRadius.circular(100),
                  //                       ),
                  //                       child: Text(
                  //                         'Go to shopping',
                  //                         style: FontTheme.labelLarge.copyWith(
                  //                             color: ColorTheme.onPrimary),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             )
                  //           : ListView.builder(
                  //               itemCount: state.selectedItem?.length ?? 0,
                  //               itemBuilder: (context, index) {
                  //                 final item = state.selectedItem?[index];
                  //                 final selectedItem =
                  //                     state.selectedItem?.firstWhere(
                  //                   (selected) => selected.id == item?.id,
                  //                   orElse: () =>
                  //                       Item(id: 0, name: '', amount: 0),
                  //                 );
                  //
                  //                 return itemTile(
                  //                   isDismissible: true,
                  //                   item: item,
                  //                   amount: selectedItem?.amount ?? 0,
                  //                 );
                  //               },
                  //             ),
                  // )
              // bottomNavigationBar:

              // show price summary
              // Container(
              //     color: Color(0xffe8def8),
              //     padding:
              //         EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //     height: 20.h,
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Subtotal',
              //               style: FontTheme.titleMedium
              //                   .copyWith(color: ColorTheme.primary),
              //             ),
              //             Text(
              //               '${formatter.format(state.subtotal ?? 0)}',
              //               style: FontTheme.titleMedium
              //                   .copyWith(color: ColorTheme.primary),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Promotion discount',
              //               style: FontTheme.titleMedium
              //                   .copyWith(color: ColorTheme.primary),
              //             ),
              //             Text(
              //               '-${formatter.format(state.discount ?? 0)}',
              //               style: FontTheme.titleMedium.copyWith(
              //                 color: Color(0xffb3261e),
              //               ),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //                 '${formatter.format(state.totalPrice ?? 0)}',
              //                 style: FontTheme.headlineLarge
              //                     .copyWith(color: ColorTheme.primary)),
              //             GestureDetector(
              //               onTap: () {
              //                 context
              //                     .read<ProductBloc>()
              //                     .add(CheckoutEvent());
              //               },
              //               child: Container(
              //                 width: 40.w,
              //                 padding: EdgeInsets.symmetric(vertical: 8),
              //                 alignment: Alignment.center,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(100),
              //                   color: ColorTheme.primary,
              //                 ),
              //                 child: Text(
              //                   'Check out',
              //                   style: FontTheme.labelLarge.copyWith(
              //                       color: ColorTheme.onPrimary),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: 15.w,
              height: 15.w,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  color: Colors.white,
                ),
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 250,
                height: 10,
                color: Colors.white,
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 250,
                height: 10,
                color: Colors.white,
              ),
            ));
      },
    );
  }

  Widget itemTile({
    Item? item,
    int? amount,
    bool isDismissible = false,
  }) {
    if (isDismissible) {
      return Dismissible(
        key: Key('${item?.id}'),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context
              .read<ProductBloc>()
              .add(AdjustAmount(item: item!, symbol: '--'));
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 32,
          ),
        ),
        child: _buildItemTile(item, amount),
      );
    } else {
      return _buildItemTile(item, amount);
    }
  }

  Widget _buildItemTile(Item? item, int? amount) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        width: 12.w,
        height: 12.w,
        child: Image.asset(
          'assets/image.png',
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        item?.name ?? '',
        style: FontTheme.titleMedium.copyWith(
          color: ColorTheme.onPrimaryContainer,
        ),
      ),
      subtitle: item == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 250,
                height: 10,
                color: Colors.white,
              ),
            )
          : RichText(
              text: TextSpan(
                text: formatter.format(item.price ?? 0),
                style: FontTheme.titleLarge.copyWith(
                  color: ColorTheme.onPrimaryContainer,
                ),
                children: [
                  TextSpan(
                    text: ' / unit',
                    style: FontTheme.titleSmall.copyWith(
                      color: ColorTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
      trailing: amount != null && amount > 0
          ? SizedBox(
              width: 25.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (item != null && amount > 0) {
                        context
                            .read<ProductBloc>()
                            .add(AdjustAmount(item: item, symbol: '-'));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorTheme.primary,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: ColorTheme.onPrimary,
                        size: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                      width: 7.w,
                      alignment: Alignment.center,
                      child: Text(
                        '$amount',
                        style: FontTheme.titleMedium,
                      )),
                  SizedBox(
                    width: 0.5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (item != null) {
                        context
                            .read<ProductBloc>()
                            .add(AdjustAmount(item: item, symbol: '+'));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorTheme.primary,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 14,
                        color: ColorTheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                if (item != null) {
                  context.read<ProductBloc>().add(
                        AdjustAmount(
                          item: item,
                          symbol: '+',
                        ),
                      );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorTheme.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  'Add to cart',
                  style: FontTheme.labelLarge
                      .copyWith(color: ColorTheme.onPrimary),
                ),
              ),
            ),
    );
  }
}
