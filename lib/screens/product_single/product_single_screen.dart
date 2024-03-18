import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/model/product_details.dart';
import 'package:watch_store/data/repo/cart_repo.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/screens/product_single/bloc/product_single_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';

class ProductSingleScreen extends StatelessWidget {
  final id;
  const ProductSingleScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productBloc = ProductSingleBloc(productRepository);
        productBloc.add(ProductSingleInit(id: id));
        return productBloc;
      },
      child: BlocBuilder<ProductSingleBloc, ProductSingleState>(
        builder: (context, state) {
          if (state is ProductSingleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductSingleLoaded) {
            return SafeArea(
                child: Scaffold(
              appBar: CustomAppBar(
                  child: Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: cartRepository.cartCount,
                      builder: (context, value, widget) {
                        return CartBadge(
                          count: value,
                        );
                      }),
                  Expanded(
                      child: FittedBox(
                    child: Text(
                      state.productDetailes.title ?? "بدون نام",
                      style: AppTextStyles.productTitle,
                      textDirection: TextDirection.rtl,
                    ),
                  )),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: SvgPicture.asset(Assets.svg.close))
                ],
              )),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          state.productDetailes.image!,
                          fit: BoxFit.cover,
                          // width: MediaQuery.sizeOf(context).width,
                          scale: 1,
                        ),
                        Container(
                          margin: const EdgeInsets.all(AppDimens.medium),
                          padding: const EdgeInsets.all(AppDimens.medium),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppDimens.medium),
                              color: AppColors.mainBg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                state.productDetailes.brand!,
                                style: AppTextStyles.productTitle,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                state.productDetailes.title!,
                                style: AppTextStyles.caption,
                                textDirection: TextDirection.rtl,
                              ),
                              const Divider(),
                              ProductTabView(
                                  productDetailes: state.productDetailes),
                              60.0.height
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocConsumer<CartBloc, CartState>(
                    listener: (cartContext, cartState) {
                      if (cartState is CartItemAddedState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: AppColors.success,
                            content: Text(
                              "با موفقیت به سبد خرید افزوده شد",
                              style: AppTextStyles.caption
                                  .copyWith(color: AppColors.onSuccess),
                              textAlign: TextAlign.center,
                            )));
                      }
                    },
                    builder: (cartContext, cartState) {
                      if (cartState is CartLoadingState) {
                        return const Positioned(
                            bottom: 0,
                            left: AppDimens.large,
                            right: AppDimens.large,
                            child: LinearProgressIndicator());
                      }
                      return Positioned(
                          bottom: 0,
                          left: AppDimens.large,
                          right: AppDimens.large,
                          child: ElevatedButton(
                              onPressed: () {
                                print(state.productDetailes.id!);
                                BlocProvider.of<CartBloc>(context).add(
                                    AddToCartEvent(state.productDetailes.id!));
                              },
                              child: const Text(
                                "افزودن به سبد خرید",
                                style: AppTextStyles.mainbuttn,
                              )));
                    },
                  )
                ],
              ),
            ));
          } else if (state is ProductSingleError) {
            return Text("error");
          } else {
            throw Exception("invalid");
          }
        },
      ),
    );
  }
}

class ProductTabView extends StatefulWidget {
  final ProductDetailes productDetailes;
  const ProductTabView({super.key, required this.productDetailes});

  @override
  State<ProductTabView> createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView> {
  var seletedTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemExtent: MediaQuery.sizeOf(context).width / 3,
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () => setState(() => seletedTabIndex = index),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.medium),
                      child: Text(tabs[index],
                          style: index == seletedTabIndex
                              ? AppTextStyles.selectedTab
                              : AppTextStyles.unSelectedTab),
                    ),
                  ))),
        ),
        IndexedStack(
          index: seletedTabIndex,
          children: [
            Review(
              text: widget.productDetailes.discussion,
            ),
            CommentsList(comments: widget.productDetailes.comments!),
            PropertiesList(
              properties: widget.productDetailes.properties!,
            )
          ],
        )
      ],
    );
  }
}

List<String> tabs = [
  "نقد و بررسی",
  "نظرات",
  "خصوصیات",
];

class PropertiesList extends StatelessWidget {
  final List<Properties> properties;
  const PropertiesList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: properties.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimens.medium),
          margin: const EdgeInsets.all(AppDimens.medium),
          color: AppColors.surfaceColor,
          child: Text(
            "${properties[index].property} : ${properties[index].value}",
            style: AppTextStyles.caption,
            textAlign: TextAlign.right,
          ),
        );
      },
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<Comments> comments;

  const CommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: comments.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimens.medium),
          margin: const EdgeInsets.all(AppDimens.medium),
          color: AppColors.surfaceColor,
          child: Text(
            "${comments[index].user} : ${comments[index].body}",
            style: AppTextStyles.caption,
            textAlign: TextAlign.right,
          ),
        );
      },
    );
  }
}

class Review extends StatelessWidget {
  final text;
  const Review({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
