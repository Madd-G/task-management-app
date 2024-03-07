// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';

class DetailTaskController extends GetxController {
  final DetailTaskState state = DetailTaskState();

  var progress;
  var status;
  var priority;
  Rx<DateTime?>? lastUpdate;

  Rx<DateTime> currentTime = DateTime.now().obs;
  Rx<DateTime> deadline = DateTime.now().obs;

  RxString timerText = ''.obs;
  late StreamSubscription<DateTime> _subscription;

  File? photo;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  RxString imageUrl = ''.obs;
  RxString imageName = ''.obs;

  DetailTaskController() {
    _subscription =
        Stream.periodic(const Duration(seconds: 1), (i) => DateTime.now())
            .listen((DateTime time) {
      currentTime.value = time;
      updateTimerText();
    });
  }

  @override
  void onInit() {
    state.task = Get.arguments;
    deadline = state.task.endDate!.obs;
    progress = state.task.progress.obs;
    status = state.task.status.obs;
    priority = state.task.priority.obs;
    lastUpdate = state.task.updatedAt.obs;

    if (state.task.updater != UserStore.to.profile.id) {
      TaskAPI.updateTaskIsRead(params: Task(id: state.task.id, isRead: true));
    }
    debugPrint('current user: ${UserStore.to.profile.toJson()}');
    super.onInit();
  }

  void updateTimerText() {
    Duration difference = deadline.value.difference(currentTime.value);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    timerText.value =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                TaskAPI.deleteTask(docId: state.task.id!);
                Get.back();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future imgFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    imageFile = pickedFile;
    imageName.value = imageFile!.name.fileName;
  }

  Future imgFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    imageFile = pickedFile;
    imageName.value = imageFile!.name;
  }

  Future<fs.UploadTask?> uploadFile(XFile? file, String id) async {
    if (file == null) {
      return null;
    }

    fs.Reference ref =
        fs.FirebaseStorage.instance.ref().child('comment').child('/$id.jpg');

    final metadata = fs.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    fs.UploadTask uploadTask = ref.putFile(File(file.path), metadata);

    await uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      imageUrl.value = url;
      Get.back();
    });

    return uploadTask;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
