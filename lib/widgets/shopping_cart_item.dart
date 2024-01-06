import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/widgets/suraface_conainer.dart';

class ShoppingCartItem extends StatelessWidget {
  ShoppingCartItem({
    super.key,
    required this.oldPrice,
    required this.productTitle,
    required this.price,
  });
  int count = 0;
  final productTitle;
  final int price;
  final int oldPrice;
  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
        child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                productTitle,
                style: AppTextStyles.productTitle.copyWith(fontSize: 12),
              ),
              Text(
                "قیمت  : ${price.separateWithComma} تومان",
                style: AppTextStyles.caption,
              ),
              Text(
                "با تخفیف: ${oldPrice.separateWithComma}  تومان",
                style: AppTextStyles.caption
                    .copyWith(color: AppColors.primaryColor),
              ),
              Divider(),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.delete)),
                  Expanded(child: const SizedBox()),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.minus)),
                  Text("عدد $count"),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svg.plus)),
                ],
              )
            ],
          ),
        ),
        Image.asset(
          Assets.png.unnamed.path,
          height: 110,
        ),
      ],
    ));
  }
}
