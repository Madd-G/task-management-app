import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
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
                      child: Icon(Icons.add, size: 12.0,))),
            ],
          ),
          const SizedBox(height: 5.0),
          if (widget.data.messages!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedContainer(
                  boxConstraints: const BoxConstraints(maxHeight: 400.0),
                  radius: 10.0,
                  borderColor: Colors.black,
                  containerColor: AppColor.borderColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.data.messages!.length,
                    itemBuilder: (context, index) {
                      var message = widget.data.messages![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (message.sender == UserStore.to.profile.id)
                                    ? 'You'
                                    : message.sender!,
                                style: CustomTextStyle.textSmallSemiBold,
                              ),
                              Text(
                                  '${message.time!.toTime()} - ${message.time!.toDateWithoutYear()}',
                                  style: CustomTextStyle.textSmallSemiBold),
                            ],
                          ),
                          Text(message.message!),
                          const SizedBox(height: 5.0),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Created at: ${widget.data.createdAt!.toTime()} - ${widget.data.createdAt?.toDate()}"),
              const SizedBox(height: 10.0),
              Text(
                  "Last update at: ${widget.data.updatedAt!.toTime()} - ${widget.data.updatedAt?.toDate()}")
            ],
          ),
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
          title: const Text('Update Business Name'),
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
