import 'dart:convert';
import 'package:get/get.dart';
import 'package:konek_mobile/common/constants/storage.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/services/services.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;

  String token = '';
  final _profile = UserEntity().obs;

  bool get isLogin => _isLogin.value;

  UserEntity get profile => _profile.value;

  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> saveProfile(UserEntity profile) async {
    _isLogin.value = true;
    print('profile.toJson(): ${profile.toJson()}');
    final profileJson = profile.toJson();
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profileJson));
    _profile(profile);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRoutes.SIGN_IN);
  }
}
