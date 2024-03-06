import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/utils/format_time.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(
      {super.key,
      required this.productName,
      required this.price,
      this.discount = 0,
      this.specialExpiration = "",
      this.oldPreice = 0});

  final productName;
  final price;
  final oldPreice;
  final discount;
  final specialExpiration;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Duration _duration = Duration(seconds: 0);
  late Timer _timer;
  late int insecond;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DateTime now = DateTime.now();
    DateTime expiration = DateTime.parse(widget.specialExpiration);
    _duration = now.difference(expiration).abs();
    insecond = _duration.inSeconds;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.small),
      margin: const EdgeInsets.all(AppDimens.medium),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.medium),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.productBgGradiant)),
      width: 200,
      child: Column(
        children: [
          Image.asset(Assets.png.unnamed.path),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.productName,
                style: AppTextStyles.productTitle,
              )),
          AppDimens.medium.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " ${600000.separateWithComma} تومان",
                    style: AppTextStyles.title,
                  ),
                  Visibility(
                      visible: widget.discount > 0 ? true : false,
                      child: Text(
                        80000000.separateWithComma,
                        style: AppTextStyles.oldPriceStyle,
                      )),
                ],
              ),
              Visibility(
                visible: widget.discount > 0 ? true : false,
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.small * .5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.red),
                  child: Text("${widget.discount} %"),
                ),
              )
            ],
          ),
          AppDimens.large.height,
          Visibility(
              visible: _duration.inSeconds > 0 ? true : false,
              child: Container(
                height: 2,
                width: double.infinity,
                color: Colors.blue,
              )),
          AppDimens.medium.height,
          Visibility(
              visible: _duration.inSeconds > 0 ? true : false,
              child: Text(
                formatTime(insecond),
                style: AppTextStyles.prodTimerStyle,
              ))
        ],
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (insecond == 0) {
          debugPrint("product onTap limited");
        } else {
          insecond--;
        }
      });
    });
  }
}
