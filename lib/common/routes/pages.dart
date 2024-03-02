import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/middlewares/middlewares.dart';
import 'package:konek_mobile/common/widgets/bottom_nav_bar.dart';
import 'package:konek_mobile/pages/auth/sign_in/index.dart';
import 'package:konek_mobile/pages/frame/task/add_task/index.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/index.dart';
import 'package:konek_mobile/pages/frame/task/index.dart';
import 'package:konek_mobile/pages/frame/welcome/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.TASK;
  static const BOTTOM_NAV_BAR = AppRoutes.BOTTOM_NAV_BAR;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.TASK,
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
      name: AppRoutes.TASK,
      page: () => const TaskPage(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_TASK,
      page: () => const AddTaskPage(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_TASK,
      page: () => const DetailTaskPage(),
      binding: DetailTaskBinding(),
    ),
  ];
}
