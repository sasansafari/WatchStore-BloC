import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/component/extention.dart';

class AppTextField extends StatelessWidget {
  final String lable;
  final String prefixLable;
  final String hint;
  TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  TextInputType? inputType;

  AppTextField(
      {required this.lable,
      required this.hint,
      required this.controller,
      this.icon = const SizedBox(),
      this.prefixLable = '',
      this.textAlign =  TextAlign.center,
      this.inputType
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(AppDimens.medium),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
             width: size.width*.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(prefixLable,style: AppTextStyles.title,),
                Text(lable,style: AppTextStyles.title,),
                
              ],
            ),
          ),
          AppDimens.medium.height,
          SizedBox(
            height: size.height*.07,
            width: size.width*.75,
            child: TextField(
              textAlign: textAlign,
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                hintStyle:  AppTextStyles.hint,
                hintText: hint,
                prefixIcon: icon
              ),

            ),
          )

        ],
      ),
      
      
      );
  }
}
