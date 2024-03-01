import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/middlewares/middlewares.dart';
import 'package:konek_mobile/common/widgets/bottom_nav_bar.dart';
import 'package:konek_mobile/pages/auth/sign_in/index.dart';
import 'package:konek_mobile/pages/frame/home/index.dart';
import 'package:konek_mobile/pages/frame/product/add_product_task_screen/index.dart';
import 'package:konek_mobile/pages/frame/product/index.dart';
import 'package:konek_mobile/pages/frame/welcome/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const HOME = AppRoutes.HOME;
  static const BOTTOM_NAV_BAR = AppRoutes.BOTTOM_NAV_BAR;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.BOTTOM_NAV_BAR,
      page: () => const BottomNavBar(),
      binding: BottomNavBarBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_PRODUCT_TASK,
      page: () => const AddProductTaskPage(),
      binding: AddProductTaskBinding(),
    ),
  ];
}
