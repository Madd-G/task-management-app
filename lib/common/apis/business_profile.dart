import 'dart:io';

import 'package:dio/dio.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/utils/http.dart';

class BusinessProfileAPI {
  static Future<BusinessProfile> getBusinessProfile() async {
    var response = await HttpUtil().get('getBusinessProfile');
    return BusinessProfile.fromJson(response);
  }

  static Future<BusinessProfile> updateName(BusinessProfile name) async {
    var response = await HttpUtil()
        .post('updateBusinessName', data: name.toJsonUpdateName());
    return BusinessProfile.fromJson(response);
  }

  static Future<BaseResponseEntity> uploadImage({File? file}) async {
    String fileName = file!.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    var response = await HttpUtil().post(
      'uploadFile',
      data: data,
    );
    return BaseResponseEntity.fromJson(response);
  }
}
