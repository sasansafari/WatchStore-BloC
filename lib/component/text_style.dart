import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/gen/fonts.gen.dart';
import 'package:watch_store/res/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle title = TextStyle(
      fontFamily: FontFamily.dana, fontSize: 14, color: AppColors.title);
  static const TextStyle selectedTab = TextStyle(
      fontFamily: FontFamily.dana, fontSize: 14, color: AppColors.title);

  static TextStyle unSelectedTab = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 14,
      color: AppColors.title.withAlpha(125));

  static const TextStyle tagTitle =
      TextStyle(fontFamily: FontFamily.dana, fontSize: 14, color: Colors.white);

  static const TextStyle productTitle = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 16,
      color: AppColors.title,
      fontWeight: FontWeight.normal);

  static TextStyle caption = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 13,
      color: AppColors.title.withAlpha(150),
      fontWeight: FontWeight.normal);

  static const TextStyle hint = TextStyle(
      fontFamily: FontFamily.dana, fontSize: 14, color: AppColors.hint);

  static const TextStyle btmNavActive = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 12,
      color: AppColors.btmNavActiveItem);

  static const TextStyle btmNavInActive = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 12,
      color: AppColors.btmNavInActiveItem);

  static const TextStyle avatarText = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 11,
      color: AppColors.title,
      fontWeight: FontWeight.w400);

  static const TextStyle oldPriceStyle = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 12,
      color: AppColors.oldPrice,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough);

  static const TextStyle prodTimerStyle = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 15,
    color: Colors.blue,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle amazingStyle = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 22,
    color: AppColors.amazingColor,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mainbuttn = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 15,
      color: AppColors.mainButtonText,
      fontWeight: FontWeight.w500);

  static const TextStyle primaryThemeTextStyle = TextStyle(
      fontFamily: FontFamily.dana,
      fontSize: 15,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w500);
}
