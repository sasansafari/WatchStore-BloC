import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/utils/image_handler.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/avatar.dart';
import 'package:watch_store/widgets/main_button.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/widgets/registeration_app_bar.dart';

import '../component/button_style.dart';
import '../res/colors.dart';
import '../route/names.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controllerNameLastName = TextEditingController();

  ImageHandler imageHandler = ImageHandler();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: RegisterationAppBar(size: size),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppDimens.large.height,
                  Avatar(
                      onTap: () {   pickImageFromCameraOrGallery(context, size);},
                      file: imageHandler.getImage),
                  AppTextField(
                      lable: AppStrings.nameLastName,
                      hint: AppStrings.hintNameLastName,
                      controller: _controllerNameLastName),
                  AppTextField(
                      lable: AppStrings.homeNumber,
                      hint: AppStrings.hintHomeNumber,
                      controller: _controllerNameLastName),
                  AppTextField(
                      lable: AppStrings.address,
                      hint: AppStrings.hintAddress,
                      controller: _controllerNameLastName),
                  AppTextField(
                      lable: AppStrings.postalCode,
                      hint: AppStrings.hintPostalCode,
                      controller: _controllerNameLastName),
                  AppTextField(
                    lable: AppStrings.location,
                    hint: AppStrings.hintLocation,
                    controller: _controllerNameLastName,
                    icon: const Icon(Icons.location_on),
                  ),
                  MainButton(
                      text: AppStrings.next,
                      onPressed: () =>
                          Navigator.pushNamed(context, ScreenNames.mainScreen)),
                  AppDimens.large.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> pickImageFromCameraOrGallery(BuildContext context, Size size) {
    return showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: size.height / 5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          child: ElevatedButton(
                              style: AppButtonStyles.mainButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          AppColors.primaryColor)),
                              onPressed: () async => await imageHandler
                                  .pickAndCropImage(
                                      source: ImageSource.gallery)
                                  .then((value) => setState(() {})),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.photo_library,
                                      color: Colors.white),
                                  Text('انتخاب عکس از گالری',
                                      style: AppTextStyles.mainbuttn),
                                ],
                              )),


                              
                        ),
                        SizedBox(
                          width: size.width / 1.8,
                          child: ElevatedButton(
                              style: AppButtonStyles.mainButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          AppColors.primaryColor)),
                              onPressed: () async => await imageHandler
                                  .pickAndCropImage(
                                      source: ImageSource.camera)
                                  .then((value) => setState(() {})),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.camera_alt_outlined,
                                      color: Colors.white),
                                  Text('انتخاب عکس از دوربین',
                                      style: AppTextStyles.mainbuttn),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
  }
}
