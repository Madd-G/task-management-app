// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:konek_mobile/common/constants/storage.dart';
import 'package:konek_mobile/common/services/services.dart';
import 'package:package_info/package_info.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  PackageInfo? _platform;

  String get version => _platform?.version ?? '-';

  bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  @override
  void onInit() {
    super.onInit();

    ///  isFirstOpen = StorageService.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, true);
  }
}
