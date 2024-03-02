import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konek_mobile/common/apis/business_profile.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'index.dart';

class ProfileController extends GetxController {
  ProfileController();

  final ProfileState state = ProfileState();

  late TextEditingController sectorController;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    sectorController = TextEditingController();
    super.onInit();
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future uploadFile() async {
    // if (_photo == null) return;
    // debugPrint(_photo);
    var result = await BusinessProfileAPI.uploadImage(file: _photo);
    debugPrint(result.data);
    if (result.code == 0) {
      // state.profileDetail.value.avatar = result.data;
      // state.profileDetail.refresh();
      state.businessProfile.value.businessLogo = result.data;
      state.businessProfile.refresh();
    } else {
      toastInfo(msg: "image error");
    }
  }

  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }

  @override
  void onClose() {
    sectorController.dispose();
    super.onClose();
  }
}
