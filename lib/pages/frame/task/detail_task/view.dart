import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/widgets/widgets.dart';
import 'index.dart';

class DetailTaskPage extends GetView<DetailTaskController> {
  const DetailTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    Task data = controller.state.task;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('task')
            .doc(data.id)
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
            if (snapshot.hasData && snapshot.data!.exists) {
              Task data = Task.fromSnapshot(snapshot.data!);
              return DetailTask(
                data: data,
                context: context,
              );
            } else {
              return const Center(
                child: Text('Document does not exist'),
              );
            }
          }
        },
      ),
    );
  }
}