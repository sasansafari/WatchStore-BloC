import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/component/extention.dart';
import 'package:watch_store/component/text_style.dart';
import 'package:watch_store/data/repo/home_rep.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/dimens.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/home/bloc/home_bloc.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/cat_widget.dart';
import 'package:watch_store/widgets/product_item.dart';
import 'package:watch_store/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(homeRepository);

        homeBloc.add(HomeInit());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeLoaded) {
                  return Column(
                    children: [
                      SearchBtn(onTap: () {}),
                      AppSlider(
                        imgList: state.home.sliders,
                      ),
                      //cat..
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.home.categories.length,
                            itemBuilder: (c, i) {
                              return CatWidget(
                                  colors: i.isEven
                                      ? AppColors.catDesktopColors
                                      : AppColors.catDigitalColors,
                                  ontap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductListScreen(
                                            param: state.home.categories[i].id),
                                      )),
                                  title: state.home.categories[i].title,
                                  iconPath: state.home.categories[i].image);
                            }),
                      ),

                      AppDimens.large.height,

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.home.amazingProducts.length,
                                  shrinkWrap: true,
                                  // reverse: true,
                                  itemBuilder: ((context, index) => ProductItem(
                                        product:
                                            state.home.amazingProducts[index],
                                      ))),
                            ),
                            const VerticalText()
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is HomeError) {
                  return const Text("error");
                } else {
                  throw Exception('invalid state');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalText extends StatelessWidget {
  const VerticalText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RotatedBox(
        quarterTurns: -1,
        child: Column(
          children: [
            Row(
              children: [
                Transform.rotate(
                    angle: 1.5, child: SvgPicture.asset(Assets.svg.back)),
                AppDimens.medium.width,
                const Text("مشاهده همه"),
              ],
            ),
            const Text(
              "شگفت انگیز",
              style: AppTextStyles.amazingStyle,
            )
          ],
        ),
      ),
    );
  }
}
