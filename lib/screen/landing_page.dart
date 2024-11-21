import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:market_app/bloc/product_bloc.dart';
import 'package:market_app/model/items_model.dart';
import 'package:market_app/screen/search_page.dart';
import 'package:market_app/style/color_theme.dart';
import 'package:market_app/style/font_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final formatter = NumberFormat('#,##0.00');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: ColorTheme.surface,
        appBar: AppBar(
          backgroundColor: ColorTheme.surface,
          leading: Container(
            width: 5.w,
            height: 5.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorTheme.primary,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ',
                style: FontTheme.titleSmall,
              ),
              Text(
                'John Doe',
                style: FontTheme.titleLarge,
              )
            ],
          ),
          actions: [Icon(Icons.shopping_bag_rounded)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: Container(
                  width: 100.w,
                  height: 10.h,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorTheme.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: ColorTheme.primary,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            'Search',
                            style: FontTheme.titleSmall
                                .copyWith(color: ColorTheme.primary),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.tune_rounded,
                        color: ColorTheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Spacial Offers',
                style: FontTheme.titleLarge,
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorTheme.onPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '20 %',
                          style: FontTheme.headlineLarge,
                        ),
                        Text(
                          'Deals!',
                          style: FontTheme.titleLarge,
                        ),
                      ],
                    ),
                    Container(
                      height: 20.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ColorTheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Quick pick ~',
                style: FontTheme.titleLarge,
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.items?.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = state.items?.items?[index];
                    final selectedItem = state.selectedItem?.firstWhere(
                      (selected) => (selected.id == item?.id),
                    );
                    return _buildItemTile(
                      item: item,
                      amount: selectedItem?.amount ?? 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget dismissibleTile({
    Item? item,
    int? amount,
  }) {
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
      child: _buildItemTile(item: item, amount: amount),
    );
  }

  Widget _buildItemTile({Item? item, int? amount}) {
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
