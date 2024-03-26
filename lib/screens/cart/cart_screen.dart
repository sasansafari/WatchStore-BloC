import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/shopping_cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(CartInitEvent());
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppBar(
          child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          AppStrings.basket,
          style: AppTextStyles.title,
        ),
      )),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: AppDimens.medium),
            padding: const EdgeInsets.all(AppDimens.medium),
            width: double.infinity,
            height: size.height * .1,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 3), blurRadius: 3)
            ], color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(Assets.svg.leftArrow)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.sendToAddress,
                        style: AppTextStyles.caption,
                      ),
                      FittedBox(
                        child: Text(
                          AppStrings.lurem,
                          style: AppTextStyles.caption,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadedState) {
                return CartList(list: state.userCart.cartList);
              } else if (state is CartItemAddedState) {
                return CartList(list: state.userCart.cartList);
              } else if (state is CartItemDeletedState) {
                return CartList(list: state.userCart.cartList);
              } else if (state is CartItemRemovedState) {
                return CartList(list: state.userCart.cartList);
              } else if (state is CartErrorState) {
                return const Text('error');
              } else if (state is CartLoadingState) {
                return const LinearProgressIndicator();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          BlocConsumer<CartBloc, CartState>(builder: (context, state) {
            UserCart? userCart;

            switch (state.runtimeType) {
              case CartLoadedState:
              case CartItemAddedState:
              case CartItemDeletedState:
              case CartItemRemovedState:
                userCart = (state as dynamic).userCart;
                break;
              case CartErrorState:
                return const Text('error');
              case CartLoadingState:
                return const LinearProgressIndicator();

              default:
                return const SizedBox();
            }

            return Visibility(
                visible: (userCart?.cartTotalPrice ?? 0) > 0,
                child: GestureDetector(
                  onTap: () =>
                      BlocProvider.of<CartBloc>(context).add(PayEvent()),
                  child: Container(
                    padding: EdgeInsets.all(AppDimens.medium),
                    margin: EdgeInsets.all(AppDimens.medium),
                    decoration: const BoxDecoration(
                        color: AppColors.surfaceColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDimens.medium))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(Assets.svg.leftArrow),
                        Column(
                          children: [
                            Text(
                              "قیمت: ${userCart?.cartTotalPrice.separateWithComma} تومان",
                              style: AppTextStyles.caption,
                            ),
                            Visibility(
                              visible: userCart?.totalWithoutDiscountPrice !=
                                  userCart?.cartTotalPrice,
                              child: Text(
                                "با تخفیف: ${userCart?.totalWithoutDiscountPrice.separateWithComma} تومان",
                                style: AppTextStyles.caption
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          }, listener: (context, state) async {
            if (state is RecivedPayLinkState) {
              final Uri url = Uri.parse(state.url);

              if (!await launchUrl(url)) {
                throw Exception('Could not Launch $url');
              }
            }
          })
        ],
      ),
    ));
  }
}

class CartList extends StatelessWidget {
  List<CartModel> list;
  CartList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return ShoppingCartItem(
                cartModel: list[index],
              );
            })));
  }
}
