import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
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
                return CartList(list: state.cartList);
              } else if (state is CartItemAddedState) {
                return CartList(list: state.cartList);
              } else if (state is CartItemDeletedState) {
                return CartList(list: state.cartList);
              } else if (state is CartItemRemovedState) {
                return CartList(list: state.cartList);
              } else if (state is CartErrorState) {
                return const Text('error');
              } else if (state is CartLoadingState) {
                return const LinearProgressIndicator();
              } else {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(CartInitEvent());
                    },
                    child: const Text("تلاش مجدد"));
              }
            },
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
          )
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
              final cartBloc = BlocProvider.of<CartBloc>(context);
              return ShoppingCartItem(
                productTitle: "ساعت شیائومی mi Watch lite",
                count: list[index].count,
                add: () => cartBloc.add(AddToCartEvent(list[index].productId)),
                remove: () =>
                    cartBloc.add(RemoveFromCartEvent(list[index].productId)),
                delete: () =>
                    cartBloc.add(DeleteFromCart(list[index].productId)),
              );
            })));
  }
}
