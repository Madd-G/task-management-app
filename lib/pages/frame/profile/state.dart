import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/business_profile.dart';

class ProfileState {
  ProfileState();

  RxBool isEdit = false.obs;
  RxBool isLoading = true.obs;

  Rx<BusinessProfile> businessProfile = BusinessProfile().obs;
}
