import 'package:get/get.dart';
import 'package:socketioio/data/models/chat_message/chat_message.dart';
import 'package:socketioio/services/socket_service.dart';

class UserService extends GetxService {
  static UserService get to =>
      Get.find(); //создание ссылки на самом себя чтобы сервисы могли общаться

  String username = '';
  final messages = RxList<ChatMessage>.empty();

  Future<UserService> init() async {
    return this;
  }

  void setUsernameAndConnect(String user) {
    username = user;
    SocketService.to.connect();
  }

  void addMessageToList(ChatMessage message) {
    printInfo(info: 'New message $message');
    messages.add(message);
  }

  void clearMessage() => messages.clear();
}
