import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socketioio/core/colors.dart';
import 'package:socketioio/data/socket_events.dart';
import 'package:socketioio/modules/chat/widget/bubble_message.dart';
import 'chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.firstPrimeryColor,
      appBar: AppBar(
        title: const Text(
          'Чат',
          style: TextStyle(
              color: AppColors.firstPrimeryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.secondPrimeryColor,
        actions: [
          IconButton(
              onPressed: () {
                controller.disconnect();
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.firstPrimeryColor,
              ))
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ListView.builder(
                    controller: controller.scrollCtrl,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      var message = controller.messages[index];
                      var itsMe = controller.itsMe(message.clientId);
                      switch (message.type) {
                        case SocketEvent.login:
                          return Center(
                              child: Text(
                            "${message.username} вошел в чат!",
                            style: const TextStyle(
                                color: AppColors.fourthPrimeryColor,
                                fontWeight: FontWeight.bold),
                          ));
                        case SocketEvent.logout:
                          return Center(
                              child: Text(
                            "${message.username} вышел из чата!",
                            style: const TextStyle(
                                color: AppColors.fourthPrimeryColor,
                                fontWeight: FontWeight.bold),
                          ));
                        case SocketEvent.newMessage:
                          return BubbleMessage(message: message, itsMe: itsMe);
                        default:
                          return const SizedBox();
                      }
                    },
                  ))),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: controller.textCtrl,
              onEditingComplete: controller.sendMessage(),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.sendMessage(),
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.secondPrimeryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
