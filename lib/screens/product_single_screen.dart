import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/widgets/app_bar.dart';
import 'package:watch_store/widgets/cart_badge.dart';

class ProductSingleScreen extends StatelessWidget {
  const ProductSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
          child: Row(
        children: [
          const CartBadge(),
          const Expanded(
              child: Text(
            'product name',
            style: AppTextStyles.productTitle,
            textDirection: TextDirection.rtl,
          )),
          IconButton(onPressed: () {}, icon: SvgPicture.asset(Assets.svg.close))
        ],
      )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  Assets.png.unnamed.path,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Container(
                  margin: const EdgeInsets.all(AppDimens.medium),
                  padding: const EdgeInsets.all(AppDimens.medium),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.medium),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "بنسر",
                        style: AppTextStyles.productTitle,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        "مسواک بنسر مدل اکسترا با برس متوسط 3 عددی",
                        style: AppTextStyles.caption,
                        textDirection: TextDirection.rtl,
                      ),
                      const Divider(),
                      ProductTabView(),
                      60.0.height
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blue,
              height: 60,
              width: double.infinity,
            ),
          )
        ],
      ),
    ));
  }
}

class ProductTabView extends StatefulWidget {
  const ProductTabView({super.key});

  @override
  State<ProductTabView> createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView> {
  var seletedTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemExtent: MediaQuery.sizeOf(context).width / 3,
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () => setState(() => seletedTabIndex = index),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.medium),
                      child: Text(tabs[index],
                          style: index == seletedTabIndex
                              ? AppTextStyles.selectedTab
                              : AppTextStyles.unSelectedTab),
                    ),
                  ))),
        ),
        IndexedStack(
          index: seletedTabIndex,
          children: [Review(), Comments(), Features()],
        )
      ],
    );
  }
}

List<String> tabs = [
  "نقد و بررسی",
  "نظرات",
  "خصوصیات",
];

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("""

خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  
خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  
خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  
خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  
خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  
خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات  خصوصیات
""");
  }
}

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Review");
  }
}

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Comments");
  }
}
