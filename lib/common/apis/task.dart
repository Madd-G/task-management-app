import 'package:konek_mobile/common/entities/entities.dart';
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
}
