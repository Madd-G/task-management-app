import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/color.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/rounded_container.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/controller.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/widgets/widgets.dart';

class DetailBody extends StatefulWidget {
  const DetailBody({super.key, required this.data});

  final Task data;

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DetailTaskController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataCarousel(data: widget.data),
              const SizedBox(height: 10.0),
              const Text(
                'Description',
                style: CustomTextStyle.text3ExtraLargeSemiBold,
              ),
              const SizedBox(height: 10.0),
              if (widget.data.imageUrl! != '') TaskImage(widget: widget),
              const SizedBox(height: 10.0),
              Text(
                widget.data.description!,
                style: CustomTextStyle.textLargeRegular,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10.0),
              const Row(
                children: [
                  Text('progress: '),
                  DetailProgressDropdown(),
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                children: [
                  Text('status     : '),
                  DetailStatusDropdown(),
                ],
              ),
              const SizedBox(height: 10.0),
              if (UserStore.to.profile.role == "owner")
                const Row(
                  children: [
                    Text('priority     : '),
                    DetailPriorityDropdown(),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Text('comment:'),
              const SizedBox(width: 5.0),
              GestureDetector(
                  onTap: () {
                    openDialog(context, controller, 'text');
                  },
                  child: const RoundedContainer(
                      containerColor: AppColor.borderColor,
                      child: Icon(
                        Icons.add,
                        size: 12.0,
                      ))),
              // const SizedBox(width: 5.0),
              // GestureDetector(
              //     onTap: () {
              //       // openDialog(context, controller, 'image');
              //       _showPicker(context, controller.state.task.id!);
              //     },
              //     child: const Icon(
              //       Icons.camera_alt,
              //       size: 15.0,
              //     )),
            ],
          ),
          const SizedBox(height: 5.0),
          if (widget.data.messages!.isNotEmpty) TaskComment(widget: widget),
          TaskCreateUpdate(widget: widget),
        ],
      ),
    );
  }

  Future<String?> openDialog(
      BuildContext context, DetailTaskController controller, String type) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add Comment'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: TextField(
            autofocus: true,
            controller: messageController,
            maxLines: 5,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Message message = Message();
                  message.sender = UserStore.to.profile.username;
                  message.message = messageController.text;
                  message.commentType = type;
                  Task task = Task();
                  task.id = controller.state.task.id;
                  task.message = message;
                  task.updater = message.sender;
                  task.isRead = false;
                  TaskAPI.addTaskMessage(params: task);
                  TaskAPI.updateTaskIsRead(params: task);
                  Get.back();
                  messageController.clear();

                  String fcmToken = await UserAPI.getEmployeeFCMToken(
                      (UserStore.to.profile.role == 'owner')
                          ? widget.data.assigneeId!
                          : 'owner');
                  if (fcmToken != '') {
                    NotificationEntity notification = NotificationEntity();
                    NotificationDetail notificationDetail = NotificationDetail(
                        title: message.sender!, body: message.message!);
                    notification = NotificationEntity(
                        notification: notificationDetail, token: '');
                    notification.token = fcmToken;
                    TaskAPI.sendNotification(notification: notification);
                  }
                },
                child: const Text('SAVE'))
          ],
        );
      },
    );
  }

  // ignore: unused_element
  void _showPicker(BuildContext context, String id) {
    final DetailTaskController controller = Get.find<DetailTaskController>();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    controller.imgFromGallery();
                    await controller.uploadFile(controller.imageFile, id);
                    // Navigator.pop(bc);
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  controller.imgFromCamera();
                  await controller.uploadFile(controller.imageFile, id);
                  // Navigator.pop(bc);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
