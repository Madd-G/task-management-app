import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:konek_mobile/pages/frame/task/widgets/widgets.dart';
import 'index.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final Offset position = button
                    .localToGlobal(const Offset(-50, 50), ancestor: overlay);
                final RelativeRect positionPopup = RelativeRect.fromRect(
                  Rect.fromPoints(
                    position,
                    position.translate(button.size.width, button.size.height),
                  ),
                  Offset.zero & overlay.size,
                );

                showMenu(
                  // constraints: const BoxConstraints(minWidth: 200.0, minHeight: 100.0, maxWidth: 200.0, maxHeight: 100.0),
                  context: context,
                  position: positionPopup,
                  items: [
                    PopupMenuItem(
                      value: UserStore.to.profile.username!,
                      child: Text('user: ${UserStore.to.profile.username!}'),
                    ),
                    PopupMenuItem(
                      value: UserStore.to.profile.role!,
                      child: Text("role: ${UserStore.to.profile.role!}"),
                    ),
                  ],
                );
              },
              child: netImageCached(
                  'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
                  width: 35.0,
                  height: 35.0),
            ),
            const Text('KONEK MOBILE'),
            const SizedBox(height: 35.0, width: 35.0)
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('task')
            .where('target',
                isEqualTo: UserStore.to.profile.role != "owner"
                    ? UserStore.to.profile.role
                    : null)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final tasks = snapshot.data!.docs
                .map((doc) => Task.fromSnapshot(doc))
                .toList();
            if (tasks.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              // ignore: avoid_function_literals_in_foreach_calls
              tasks.forEach((task) {
                if (task.endDate != null &&
                    DateTime.now().isAfter(
                        task.endDate!.subtract(const Duration(hours: 1))) &&
                    DateTime.now().isBefore(task.endDate!) &&
                    task.isNotificationSent == false &&
                    UserStore.to.profile.role != 'owner' &&
                    task.status != 'done') {
                  debugPrint('...triggered');
                  if (UserStore.to.profile.token != '') {
                    NotificationEntity notification = NotificationEntity();
                    NotificationDetail notificationDetail =
                        NotificationDetail(title: "owner", body: task.name!);
                    notification =
                        NotificationEntity(notification: notificationDetail);
                    notification.token = UserStore.to.profile.fcmToken;
                    TaskAPI.sendNotification(notification: notification);
                    TaskAPI.updateTaskIsNotificationSent(
                        params: Task(id: task.id, isNotificationSent: true));
                  }
                }
              });

              return Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: tasks[index]);
                  },
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: (UserStore.to.profile.role == "owner")
          ? FloatingActionButton(
              backgroundColor: AppColor.accentColor,
              onPressed: () {
                Get.toNamed(AppRoutes.ADD_TASK);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
