import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'index.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Task List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('task').snapshots(),
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
            final products = snapshot.data!.docs
                .map((doc) => Task.fromSnapshot(doc))
                .toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return TaskCard(product: products[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.accentColor,
        onPressed: () {
          Get.toNamed(AppRoutes.ADD_TASK);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
