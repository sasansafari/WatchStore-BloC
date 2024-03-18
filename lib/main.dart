import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/component/themes.dart';
import 'package:watch_store/data/repo/cart_repo.dart';
import 'package:watch_store/route/routes.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/screens/auth/send_sms_screen.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';
import 'package:watch_store/screens/mainscreen/main_screen.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Watch Store',
        theme: lightTheme(),
        // initialRoute: ScreenNames.root,
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) {
                      final cartBloc = CartBloc(cartRepository);
                      cartBloc.add(CartInitEvent());
                      cartBloc.add(CartItemCountEvent());
                      return cartBloc;
                    },
                  ),
                ],
                child: MainScreen(),
              );
            } else if (state is LoggedOutState) {
              return SendSmsScreen();
            } else {
              return SendSmsScreen();
            }
          },
        ),
      ),
    );
  }
}
