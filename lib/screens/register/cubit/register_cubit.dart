import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/user.dart';
import 'package:watch_store/utils/shared_preferences_constants.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final Dio _dio = Dio();

  pickTheLocation({required context}) async {
    await showSimplePickerLocation(
            isDismissible: true,
            title: "انتخاب موقعیت مکانی",
            textCancelPicker: "لغو",
            textConfirmPicker: "انتخاب",
            zoomOption: const ZoomOption(initZoom: 8),
            // initCurrentUserPosition: UserTrackingOption.withoutUserPosition(),
            initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
            radius: 8.0,
            context: context)
        .then((value) => emit(LocationPickedState(location: value)));
  }

  register({required User user}) async {
    emit(LoadingState());
    print(user.toMap());
    try {
      String? token = SharedPreferencesManager()
          .getString(SharedPreferencesConstants.token);

      _dio.options.headers["Authorization"] = "Bearer $token";
      await _dio
          .post(
        Endpoints.register,
        data: FormData.fromMap(user.toMap()),
      )
          .then((value) {
        print(value.statusCode);
        if (value.statusCode == 201) {
          emit(OkResponseState());
        } else {
          emit(ErrorState());
        }
      });
    } catch (e) {
      print(e.toString());
      emit(ErrorState());
    }
  }



    Future<void> pickAndCropImage({required ImageSource source}) async {
   File _image;
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
      emit(CancelImageState());
      }
      File? img = File(image!.path);
      img = await _cropImage(imageFile: img);
      _image = img!;
      emit(IntialImageState(image: _image));
    } catch (e) {
      emit(CancelImageState());
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (imageFile == null){
       emit(CancelImageState());
    }
    return File(croppedImage!.path);
  }
}
