import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/task.dart' as task;
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'index.dart';
import 'dart:io';

class AddTaskController extends GetxController {
  final AddTaskState state = AddTaskState();
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final descriptionController = TextEditingController();
  final addCompanyFormKey = GlobalKey<FormState>();
  File? photo;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  RxString status = 'To Do'.obs;
  RxString priority = 'Low'.obs;
  RxString category = 'Category'.obs;
  RxString employeeName = 'Assignee'.obs;
  RxString employeeId = ''.obs;
  RxString? fcmToken = ''.obs;
  RxString imageUrl = ''.obs;
  RxString employeeRole = ''.obs;
  Rx<DateTime>? startDate = DateTime.now().obs;
  Rx<DateTime>? endDate = DateTime.now().obs;
  RxString imageName = ''.obs;

  @override
  void onInit() {
    getEmployee();
    super.onInit();
  }

  Future<void> getEmployee() async {
    state.employeeList.value = await UserAPI.getEmployees();
  }

  void addTask(task.Task product) {
    TaskAPI.addTask(params: product);
    Get.back();
  }

  void dateTimePickerWidget(BuildContext context, String date) {
    DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(2050),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        if (date == "start date") {
          startDate?.value = dateTime;
        } else if (date == "end date") {
          endDate?.value = dateTime;
        }
        update();
      },
    );
  }

  Future imgFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    imageFile = pickedFile;
    if (imageFile != null) {
      imageName.value = imageFile!.name;
    }
    imageName.value = imageFile!.name.fileName;
  }


  Future imgFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    imageFile = pickedFile;
    if (imageFile != null) {
      imageName.value = imageFile!.name;
    }
  }

  Future<UploadTask?> uploadFile(XFile? file, String id) async {
    if (file == null) {
      return null;
    }

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('image')
        .child('/$id.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);

    await uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      imageUrl.value = url;
      Get.back();
    });

    return uploadTask;
  }

  @override
  void onClose() {
    nameController.dispose();
    weightController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
