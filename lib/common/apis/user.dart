import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

class UserAPI {
  static Future<UserEntity> login({
    UserEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'auth/login',
      data: params?.toJsonRequest(),
    );
    if (response['code'] == 1) {
      UserEntity userItem = UserEntity.fromJsonResponse(response);

      return userItem;
    } else {
      toastInfo(msg: 'Error occurred');
      return UserEntity();
    }
  }

  static Future<void> updateDeviceToken({
    UserEntity? params,
  }) async {
    await HttpUtil().post(
      'updateDeviceToken',
      data: params?.toJsonUpdateDeviceToken(),
    );
  }

  static Future<void> deleteDeviceToken({
    UserEntity? params,
  }) async {
    await HttpUtil().post(
      'deleteDeviceToken',
      data: params?.toJsonDeleteDeviceToken(),
    );
  }

  static Future<List<UserEntity>> getEmployees() async {
    try {
      var response = await HttpUtil().get('getEmployeeNameRole');
      final List<dynamic> data = response;
      return data.map((item) => UserEntity.fromJson(item)).toList();
    } catch (error) {
      throw Exception('Failed to load employees');
    }
  }

  static Future<String> getEmployeeFCMToken(String id) async {
    var requestBody = {"doc_id": id};
    var response =
        await HttpUtil().post('getEmployeeFCMToken', data: requestBody);
    var fcmToken = response['fcmToken'];
    return fcmToken;
  }
}
