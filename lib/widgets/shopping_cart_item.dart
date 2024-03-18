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
    required this.productTitle,
    required this.count,
    this.add,
    this.remove,
    this.delete,
  });
  int count = 0;
  final productTitle;
  final add;
  final remove;
  final delete;

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
        child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productTitle,
            style: AppTextStyles.productTitle.copyWith(fontSize: 12),
          ),
          Divider(),
          Row(
            children: [
              IconButton(
                  onPressed: delete, icon: SvgPicture.asset(Assets.svg.delete)),
              Expanded(child: const SizedBox()),
              IconButton(
                  onPressed: remove, icon: SvgPicture.asset(Assets.svg.minus)),
              Text("عدد $count"),
              IconButton(
                  onPressed: add, icon: SvgPicture.asset(Assets.svg.plus)),
            ],
          )
        ],
      ),
    ));
  }
}
