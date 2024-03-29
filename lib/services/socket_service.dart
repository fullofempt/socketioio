import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socketioio/data/models/chat_message/chat_message.dart';
import 'package:socketioio/data/socket_events.dart';
import 'package:socketioio/routes/pages.dart';
import 'package:socketioio/services/user_service.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();
  late Socket _socket; //переменная, которая хранит само подключение

  Future<SocketService> init() async {
    _socket = io(
        'https://masqed.ru',
        OptionBuilder()
            .setTransports(['websocket']) //подключаем вебсокеты
            .setPath('/chat/socket.io') //путь по которому мы подключаемся
            .disableAutoConnect() //отключения автоподключения
            .disableReconnection() //отключение переподключения
            .build());
             
    _socket.onConnect((data) {
       printInfo(info: 'Socked connected');
      _sendLoginMessage();
      Get.offNamed(Routes.CHAT);
    });

    _socket.onDisconnect((data) {
      UserService.to.clearMessage();
      printInfo(info: 'Socket disconnected');
      Get.offNamed(Routes.HOME);
      });
    _socket
        .onConnectError((data) => printInfo(info: 'Socket connection error'));

    _socket.onAny((event, data) {
      var isKnown = SocketEvent.values.any((element) => element.name == event);
      if (!isKnown) return;
      data?['type'] = event;
      var message = ChatMessage.fromJson(data);
      UserService.to.addMessageToList(message);
    });

    return this;
  }

  String get clientId => _socket.id ?? "";

  void connect() {
    //подключение
    _socket.connect();
  }

  void disconnect() async{
    //отключение
    _sendLogoutMessage();
    await Future.delayed(const Duration(seconds: 2)); //TODO костыль
    _socket.disconnect();
  }

  void _sendLoginMessage() {
    _socket.emit(SocketEvent.login.name, UserService.to.username);
  }

  void _sendLogoutMessage() {
    _socket.emit(SocketEvent.logout.name);
  }

  void sendMessageToChat(String message) {
    _socket.emit(SocketEvent.newMessage.name, message);
  }
}
