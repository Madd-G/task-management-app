import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/utils/utils.dart';

class ProductAPI {
  static void addProductTask({
    Task? params,
  }) async {
    await HttpUtil().post(
      'addProductTask',
      data: params?.toJson(),
    );
  }
}
