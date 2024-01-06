import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watch_store/component/button_style.dart';
import 'package:watch_store/component/text_style.dart';

class MainButton extends StatelessWidget {

  final String text;
  void Function() onPressed;

    MainButton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return  SizedBox(
            height: size.height*.07,
            width: size.width*.75,
            child: ElevatedButton(
              style: AppButtonStyles.mainButtonStyle,
              onPressed: onPressed,
              child: Text(text,style: AppTextStyles.mainbuttn,)),
            );
  }
}