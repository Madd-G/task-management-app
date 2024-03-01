import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/res/media_res.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/style/color.dart';
import 'package:konek_mobile/pages/frame/home/index.dart';
import 'package:konek_mobile/pages/frame/product/index.dart';
import 'package:konek_mobile/pages/frame/profile/index.dart';

class BottomNavBar extends GetView<BottomNavBarController> {
  const BottomNavBar({super.key});

  static const List<String> _activeIcons = [
    MediaRes.homeFilled,
    MediaRes.homeFilled,
    MediaRes.userFilled,
  ];

  static const List<String> _inActiveIcons = [
    MediaRes.home,
    MediaRes.home,
    MediaRes.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: AppPages.HOME,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          color: AppColor.baseWhite,
          height: 75.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) {
                bool isActive = controller.state.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.changePage(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (isActive)
                          ? SvgPicture.asset(
                              _activeIcons[index],
                              colorFilter: const ColorFilter.mode(
                                AppColor.accentColor,
                                BlendMode.srcIn,
                              ),
                              height: 24.0,
                              width: 24.0,
                            )
                          : SvgPicture.asset(
                              _inActiveIcons[index],
                              colorFilter: const ColorFilter.mode(
                                AppColor.secondaryText,
                                BlendMode.srcIn,
                              ),
                              height: 24.0,
                              width: 24.0,
                            ),
                      const SizedBox(height: 10.0),
                      (isActive)
                          ? SizedBox(
                              height: 13.0,
                              child: Image.asset(MediaRes.bar),
                            )
                          : const SizedBox(height: 13.0)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarController extends GetxController {
  BottomNavBarController();

  final BottomNavBarState state = BottomNavBarState();

  void changePage(int index) {
    state.selectedIndex.value = index;
    Get.toNamed(state.pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomePage(),
        binding: HomeBinding(),
      );
    }

    if (settings.name == AppRoutes.PRODUCT) {
      return GetPageRoute(
        settings: settings,
        page: () => ProductPage(),
        binding: ProductBinding(),
      );
    }
    if (settings.name == AppRoutes.PROFILE) {
      return GetPageRoute(
        settings: settings,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
      );
    }

    return null;
  }
}

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
  }
}

class BottomNavBarState {
  var selectedIndex = 0.obs;
  final pages = <String>[
    AppRoutes.HOME,
    AppRoutes.PRODUCT,
    AppRoutes.PROFILE,
  ];
}
