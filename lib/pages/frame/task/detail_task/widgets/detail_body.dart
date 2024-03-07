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
                    openDialog(context, controller);
                  },
                  child: const RoundedContainer(
                      containerColor: AppColor.borderColor,
                      child: Icon(
                        Icons.add,
                        size: 12.0,
                      ))),
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
      BuildContext context, DetailTaskController controller) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add Comment'),
          content: TextField(
            autofocus: true,
            controller: messageController,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Message message = Message();
                  message.sender = UserStore.to.profile.id;
                  message.message = messageController.text;
                  Task task = Task();
                  task.id = controller.state.task.id;
                  task.message = message;
                  task.updater = message.sender;
                  task.isRead = false;
                  TaskAPI.addTaskMessage(params: task);
                  TaskAPI.updateTaskIsRead(params: task);
                  Get.back();
                  messageController.clear();
                },
                child: const Text('SAVE'))
          ],
        );
      },
    );
  }
}
