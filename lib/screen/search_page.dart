import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:market_app/bloc/product_bloc.dart';
import 'package:market_app/model/items_model.dart';
import 'package:market_app/style/color_theme.dart';
import 'package:market_app/style/font_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final formatter = NumberFormat('#,##0.00');
  final TextEditingController _searchController = TextEditingController();
  List<Item> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      final items = state.items ?? [];
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorTheme.surface,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                          Container(
                            width: 100.w,
                            height: 10.h,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search products...',
                                border: InputBorder.none,
                              ),
                              style: FontTheme.titleMedium
                                  .copyWith(color: ColorTheme.primary),
                            ),
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
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: items.length,
                //     itemBuilder: (context, index) {
                //       final item = items[index];
                //       return _buildItemTile(item: item);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildItemTile({Item? item}) {
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
      trailing: GestureDetector(
        onTap: () {
          if (item != null) {
            context.read<ProductBloc>().add(
                  AdjustAmount(item: item, symbol: '+'),
                );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorTheme.primary,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            'Add to cart',
            style: FontTheme.labelLarge.copyWith(color: ColorTheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
