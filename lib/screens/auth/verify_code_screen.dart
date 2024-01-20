import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/route/names.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/main_button.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final moblieRouteArg = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.png.mainLogo.path),
            AppDimens.medium.height,
            Text(
              AppStrings.otpCodeSendFor
                  .replaceAll(AppStrings.replace, moblieRouteArg),
              style: AppTextStyles.title,
            ),
            AppDimens.small.height,
            const Text(
              AppStrings.wrongNumberEditNumber,
              style: AppTextStyles.primaryThemeTextStyle,
            ),
            AppDimens.large.height,
            AppTextField(
              lable: AppStrings.enterVerificationCode,
              hint: AppStrings.hintVerificationCode,
              controller: _controller,
              prefixLable: "2:56",
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is VerifiedNotRegisteState) {
                  Navigator.pushNamed(context, ScreenNames.registerScreen);
                } else if (state is VerifiedIsRegisterState) {
                  Navigator.pushNamed(context, ScreenNames.mainScreen);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return MainButton(
                      text: AppStrings.next,
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context)
                            .verifyCode(moblieRouteArg, _controller.text);
                      });
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
