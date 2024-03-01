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
}
