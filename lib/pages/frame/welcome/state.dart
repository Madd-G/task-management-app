import 'package:get/get.dart';

class WelcomeState {
  WelcomeState();

  var index = 0.obs;
  final _obj = ''.obs;

  set obj(value) => this._obj.value = value;

  get obj => this._obj.value;
  final title = "KONEK MOBILE";

}
