import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/res/strings.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image.asset(Assets.png.avatar.path),
        ),
        AppDimens.medium.height,
        Text(
          AppStrings.chooseProfileImage,
          style: AppTextStyles.avatarText,
        )
      ],
    );
  }
}
