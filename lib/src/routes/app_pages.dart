import 'package:get/get.dart';
import 'package:greengrocer_course/src/pages/base/base_screen.dart';
import 'package:greengrocer_course/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocer_course/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer_course/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer_course/src/pages/splash/splash_screen.dart';

import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sign_up_screen.dart';

abstract class AppPages{

  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute, 
    ),

    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute, 
    ),

    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute, 
    ),

    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute, 
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding()
      ]
    ),

  ];

}

abstract class PagesRoutes {

  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/';

}