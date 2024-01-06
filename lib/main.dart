import 'package:flutter/material.dart';
import 'package:watch_store/component/themes.dart';
import 'package:watch_store/route/names.dart';
import 'package:watch_store/route/routes.dart';
import 'package:watch_store/screens/cart.dart';
import 'package:watch_store/screens/product_list_screen.dart';
import 'package:watch_store/screens/product_single_screen.dart';
import 'package:watch_store/screens/send_otp_screen.dart';

import 'screens/get_otp_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Store',
      theme: lightTheme(),
      initialRoute: ScreenNames.root,
      // routes: routes,
      home: const CartScreen(),
    );
  }
}
