import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';
import 'dart:io' as io;

class ProfileController extends GetxController {
  ProfileController();

  final ProfileState state = ProfileState();

  late TextEditingController sectorController;

  File? photo;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    sectorController = TextEditingController();
    super.onInit();
  }

  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }

  deleteDeviceToken() async {
    UserEntity user = UserEntity();
    user.id = UserStore.to.profile.id;
    UserAPI.deleteDeviceToken(params: user);
  }

  Future imgFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    await uploadFile(pickedFile);
  }

  Future imgFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    await uploadFile(pickedFile);
  }

  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      return null;
    }

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('logo')
        .child('/${UserStore.to.profile.id}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    UploadTask uploadTask = ref.putFile(io.File(file.path), metadata);

    await uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      await BusinessProfileAPI.updateLogo(BusinessProfile(businessLogo: url));
      Get.back();
    });

    return uploadTask;
  }

  @override
  void onClose() {
    sectorController.dispose();
    super.onClose();
  }
}
