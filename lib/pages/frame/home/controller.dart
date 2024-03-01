import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  HomeController();

  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
