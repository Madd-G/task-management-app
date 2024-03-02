import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/entities/notification.dart';
import 'package:konek_mobile/common/utils/utils.dart';

class TaskAPI {
  static void addTask({
    Task? params,
  }) async {
    await HttpUtil().post(
      'addTask',
      data: params?.toJson(),
    );
  }

  static void updateTaskProgress({
    Task? params,
  }) async {
    await HttpUtil().post(
      'updateTaskProgress',
      data: params?.toJsonProgress(),
    );
  }

  static void updateTaskStatus({
    Task? params,
  }) async {
    await HttpUtil().post(
      'updateTaskStatus',
      data: params?.toJsonStatus(),
    );
  }

  static void updateTaskPriority({
    Task? params,
  }) async {
    await HttpUtil().post(
      'updateTaskPriority',
      data: params?.toJsonPriority(),
    );
  }

  static void deleteTask({
    required String docId,
  }) async {
    await HttpUtil().delete(
      'deleteTask/$docId',
    );
  }

  static void sendNotification({NotificationEntity? notification}) async {
    await HttpUtil().post(
      'sendNotification',
      data: notification?.toJson(),
    );
  }
}
