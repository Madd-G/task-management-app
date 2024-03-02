import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/pages/frame/task/widgets/widgets.dart';
import 'index.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('KONEK MOBILE'),
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
