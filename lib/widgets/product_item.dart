import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/screens/product_single/product_single_screen.dart';
import 'package:watch_store/utils/format_time.dart';

class ProductItem extends StatefulWidget {
  ProductItem({
    super.key,
    required this.product,
  });
  Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Duration _duration = Duration(seconds: 0);
  late Timer _timer;
  int insecond = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(_duration, () {});
    if (widget.product.specialExpiration != "") {
      DateTime now = DateTime.now();
      DateTime expiration = DateTime.parse(widget.product.specialExpiration);
      _duration = now.difference(expiration).abs();
      insecond = _duration.inSeconds;
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductSingleScreen(
                    id: widget.product.id,
                  ))),
      child: Container(
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
            Image.network(widget.product.image),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.product.title,
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
                      " ${widget.product.price.separateWithComma} تومان",
                      style: AppTextStyles.title,
                    ),
                    Visibility(
                        visible: widget.product.discount > 0 ? true : false,
                        child: Text(
                          widget.product.discountPrice.separateWithComma,
                          style: AppTextStyles.oldPriceStyle,
                        )),
                  ],
                ),
                Visibility(
                  visible: widget.product.discount > 0 ? true : false,
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.small * .5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.red),
                    child: Text("${widget.product.discount} %"),
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
