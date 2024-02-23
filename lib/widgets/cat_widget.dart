import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/component/text_style.dart';

import '../res/dimens.dart';

class CatWidget extends StatelessWidget {
  const CatWidget({
    super.key,
    required this.colors,
    required this.ontap,
    required this.title,
    required this.iconPath,
  });

  final title;
  final ontap;
  final colors;
  final iconPath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(AppDimens.small),
            height: size.height * .1,
            width: size.height * .1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: colors),
                borderRadius: BorderRadius.circular(AppDimens.large)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 60,
                    child: Image.network(
                      iconPath,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimens.small * .5,
          ),
          Text(
            title,
            style: AppTextStyles.title.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
