import 'package:flutter/material.dart';
import 'package:watch_store/component/themes.dart';
import 'package:watch_store/route/names.dart';
import 'package:watch_store/route/routes.dart';

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
      routes: routes,
      // home: const CartScreen(),
    );
  }
}
