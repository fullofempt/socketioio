import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socketioio/services/user_service.dart';

class HomeController extends GetxController {
  final textCtrl = TextEditingController();

  void signIn() {
    String username = textCtrl.text;
    print(username);
    UserService.to.setUsernameAndConnect(username);
  }

}
