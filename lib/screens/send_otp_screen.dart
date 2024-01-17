import 'package:flutter/material.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/route/names.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/main_button.dart';

class SendOtpScreen extends StatelessWidget {
  SendOtpScreen({super.key});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.png.mainLogo.path),
            AppDimens.large.height,
            AppTextField(
              lable: AppStrings.enterYourNumber,
              hint: AppStrings.hintPhoneNumber,
              controller: _controller,
            ),
            MainButton(
                text: AppStrings.next,
                onPressed: () =>
                    Navigator.pushNamed(context, ScreenNames.getOtpScreen))
          ],
        ),
      )),
    );
  }
}
