import 'package:flutter/material.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.price,
    this.discount = 0,
    this.time= 0,
    this.oldPreice=0
  });

  final productName;
  final price;
  final oldPreice;
  final discount;
  final time;


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
          colors:AppColors.productBgGradiant)
      ),
      width: 200,
      child: Column(
        
        children: [
          
          Image.asset(Assets.png.unnamed.path),
            Align(
            alignment: Alignment.centerRight,
            child: Text(productName,style: AppTextStyles.productTitle,)),
          AppDimens.medium.height,

          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ${600000.separateWithComma} تومان",style: AppTextStyles.title,),
                  Visibility(
                    visible: discount>0?true:false,
                    child: Text(80000000.separateWithComma,style: AppTextStyles.oldPriceStyle,)),
                ],
              ),
              Visibility(
                visible: discount>0?true:false,
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.small*.5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: Colors.red),
                  child:   Text("$discount %"),
                ),
              )

            ],
          ),
          AppDimens.large.height,

          Visibility(
            visible: time>0?true:false,
            child: Container(height: 2,width: double.infinity,color: Colors.blue,)),

          AppDimens.medium.height,

            Visibility(
                        visible: time>0?true:false,

            child: const Text("09:26:22",style: AppTextStyles.prodTimerStyle,))


        ],
      ),
    );
  }
}
