import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/suraface_conainer.dart';

class ShoppingCartItem extends StatefulWidget {
  ShoppingCartItem({super.key, required this.cartModel});
  CartModel cartModel;

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return SurfaceContainer(
        child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.cartModel.product,
            style: AppTextStyles.productTitle.copyWith(fontSize: 12),
          ),
          const Divider(),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() => widget.cartModel.deleteLoading = true);
                    cartBloc.add(DeleteFromCart(widget.cartModel.productId));
                  },
                  icon: SvgPicture.asset(Assets.svg.delete)),
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    setState(() => widget.cartModel.countLoading = true);
                    cartBloc
                        .add(RemoveFromCartEvent(widget.cartModel.productId));
                  },
                  icon: SvgPicture.asset(Assets.svg.minus)),
              widget.cartModel.countLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : Text("عدد ${widget.cartModel.count}"),
              IconButton(
                  onPressed: () {
                    setState(() => widget.cartModel.countLoading = true);
                    cartBloc.add(AddToCartEvent(widget.cartModel.productId));
                  },
                  icon: SvgPicture.asset(Assets.svg.plus)),
            ],
          ),
          Visibility(
              visible: widget.cartModel.deleteLoading,
              child: const LinearProgressIndicator())
        ],
      ),
    ));
  }
}
