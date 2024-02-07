import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_store/component/button_style.dart';
import 'package:watch_store/data/model/user.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/register/cubit/register_cubit.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/avatar.dart';
import 'package:watch_store/widgets/main_button.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/widgets/registeration_app_bar.dart';
import 'package:geocoding/geocoding.dart';
import '../../component/text_style.dart';
import '../../res/colors.dart';
import '../../route/names.dart';

//sasansafari_dev

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controllerNameLastName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerPostalCode = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  double lat = 0.0;
  double lng = 0.0;
  var image = null;

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
              child: BlocProvider(
                create: (context) => RegisterCubit(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppDimens.large.height,
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (contxt, state) {
                        if (state is IntialImageState) {
                          image = state.image;
                        }
                        if (state is CancelImageState) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Cancel')));
                        }
                      },
                      builder: (contxt, state) {
                        return Avatar(
                            onTap: () {
                              galleryOrcamera(context, size, contxt);
                            },
                            file: image);
                      },
                    ),
                    AppTextField(
                        lable: AppStrings.nameLastName,
                        hint: AppStrings.hintNameLastName,
                        controller: _controllerNameLastName),
                    AppTextField(
                        lable: AppStrings.homeNumber,
                        hint: AppStrings.hintHomeNumber,
                        controller: _controllerPhone),
                    AppTextField(
                        lable: AppStrings.address,
                        hint: AppStrings.hintAddress,
                        controller: _controllerAddress),
                    AppTextField(
                        lable: AppStrings.postalCode,
                        hint: AppStrings.hintPostalCode,
                        controller: _controllerPostalCode),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) async {
                        if (state is LocationPickedState) {
                          if (state.location != null) {
                            _controllerLocation.text =await getAddress(state.location!.longitude ,state.location!.latitude);

                            lat = state.location!.latitude;
                            lng = state.location!.longitude;
                          }
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<RegisterCubit>(context)
                                .pickTheLocation(context: context);
                          },
                          child: AppTextField(
                            lable: AppStrings.location,
                            hint: AppStrings.hintLocation,
                            controller: _controllerLocation,
                            icon: const Icon(Icons.location_on),
                          ),
                        );
                      },
                    ),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is OkResponseState) {
                          Navigator.pushNamed(context, ScreenNames.mainScreen);
                        } else if (state is ErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("خطایی رخ داده")));
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
                              onPressed: () async {
                                User user = User(
                                    name: _controllerNameLastName.text,
                                    phone: _controllerPhone.text,
                                    address: _controllerAddress.text,
                                    postalCode: _controllerPostalCode.text,
                                    image: await MultipartFile.fromFile(
                                        image.path),
                                    lat: lat,
                                    lng: lng);

                                BlocProvider.of<RegisterCubit>(context)
                                    .register(user: user);
                              });
                        }
                      },
                    ),
                    AppDimens.large.height,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
Future<String> getAddress(double lng, double lat) async {
    String address = '';
    try {
      await placemarkFromCoordinates(lat,lng,localeIdentifier: 'fa')
          .then((value) {
        Placemark first = value.first;

        address = '${first.street}' '${first.locality}' '${first.country}';
      });
      print(lat.toString());
      print(lng.toString());
      return address;
    } catch (e) {
      return 'آدرس یافت نشد';
    }
  }

Future<dynamic> galleryOrcamera(
      BuildContext context, Size size, BuildContext contxt) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          height: size.height / 5,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width / 1.8,
                  child: ElevatedButton(
                      style: AppButtonStyles.mainButtonStyle.copyWith(
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.primaryColor)),
                      onPressed: () async =>
                          await BlocProvider.of<RegisterCubit>(contxt)
                              .pickAndCropImage(source: ImageSource.gallery),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.photo_library, color: Colors.white),
                          Text('انتخاب عکس از گالری',
                              style: AppTextStyles.mainbuttn),
                        ],
                      ))),
              SizedBox(
                width: size.width / 1.8,
                child: ElevatedButton(
                    style: AppButtonStyles.mainButtonStyle.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(
                            AppColors.primaryColor)),
                    onPressed: () async =>
                        await BlocProvider.of<RegisterCubit>(contxt)
                            .pickAndCropImage(source: ImageSource.camera),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.white),
                        Text('انتخاب عکس از دوربین',
                            style: AppTextStyles.mainbuttn),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
