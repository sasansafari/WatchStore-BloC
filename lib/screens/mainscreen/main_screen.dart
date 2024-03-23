import 'package:flutter/material.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/screens/cart/cart_screen.dart';
import 'package:watch_store/screens/profile/profile_screen.dart';
import 'package:watch_store/widgets/btm_nav_item.dart';

import '../home/home_screen.dart';

class BtmNavScreenIndex {
  BtmNavScreenIndex._();
  static const home = 0;
  static const basket = 1;
  static const profile = 2;
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<int> _routeHistory = [BtmNavScreenIndex.home];

  int selectedIndex = BtmNavScreenIndex.home;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _basketKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late final map = {
    BtmNavScreenIndex.home: _homeKey,
    BtmNavScreenIndex.basket: _basketKey,
    BtmNavScreenIndex.profile: _profileKey,
  };

  // map[0] => _homeKey
  // map[1] => _basketKey
  // map[2] => _profileKey

  Future<bool> _onWillPop() async {
    if (map[selectedIndex]!.currentState!.canPop()) {
      map[selectedIndex]!.currentState!.pop();
    } else if (_routeHistory.length > 1) {
      setState(() {
        _routeHistory.removeLast();
        selectedIndex = _routeHistory.last;
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double btmNavHeight = size.height * .1;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: btmNavHeight,
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    Navigator(
                      key: _homeKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    ),
                    Navigator(
                      key: _basketKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const CartScreen()),
                    ),
                    Navigator(
                      key: _profileKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    ),
                  ],
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.btmNavColor,
                  height: btmNavHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BtmNavItem(
                          iconSvgPath: Assets.svg.user,
                          text: "پروفایل",
                          isActive: selectedIndex == BtmNavScreenIndex.profile,
                          onTap: () => btmNavOnPressed(
                              index: BtmNavScreenIndex.profile)),
                      BtmNavItem(
                          iconSvgPath: Assets.svg.cart,
                          text: "سبد خرید",
                          isActive: selectedIndex == BtmNavScreenIndex.basket,
                          onTap: () =>
                              btmNavOnPressed(index: BtmNavScreenIndex.basket)),
                      BtmNavItem(
                          iconSvgPath: Assets.svg.home,
                          text: "خانه",
                          isActive: selectedIndex == BtmNavScreenIndex.home,
                          onTap: () =>
                              btmNavOnPressed(index: BtmNavScreenIndex.home)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  btmNavOnPressed({required index}) {
    setState(() {
      selectedIndex = index;
      _routeHistory.add(selectedIndex);
    });
  }
}
