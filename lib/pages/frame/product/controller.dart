import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';

class ProductController extends GetxController {
  final ProductState state = ProductState();

  ProductController();

  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
