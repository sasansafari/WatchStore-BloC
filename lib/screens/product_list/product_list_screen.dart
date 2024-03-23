import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/repo/cart_repo.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_list/bloc/product_list_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';
import 'package:watch_store/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  final param;
  ProductListScreen({super.key, this.param});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productListBloc = ProductListBloc(productRepository);
        productListBloc.add(ProductListInit(param: param));
        return productListBloc;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                    valueListenable: cartRepository.cartCount,
                    builder: (context, value, widget) {
                      return CartBadge(
                        count: value,
                      );
                    }),
                Row(
                  children: [
                    const Text("پرفروشترین ها"),
                    AppDimens.small.width,
                    SvgPicture.asset(Assets.svg.sort)
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(Assets.svg.close)),
              ],
            )),
            body: Column(
              children: [
                TagList(),
                BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, state) {
                    if (state is ProductListLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProductListLoaded) {
                      return Expanded(
                          child: GridView.builder(
                              itemCount: state.productList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                      childAspectRatio: 0.5),
                              itemBuilder: (context, index) => ProductItem(
                                    product: state.productList[index],
                                  )));
                    } else if (state is ProductListError) {
                      return const Text("error");
                    } else {
                      throw Exception("invalid state");
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}

class TagList extends StatelessWidget {
  const TagList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.medium),
      child: SizedBox(
        height: 24,
        child: ListView.builder(
            reverse: true,
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: AppDimens.small),
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.small),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(AppDimens.large)),
                child: const Text(
                  "نیوفورس",
                  style: AppTextStyles.tagTitle,
                ),
              );
            }),
      ),
    );
  }
}
