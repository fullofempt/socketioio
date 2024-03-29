import 'package:flutter/material.dart';
import 'package:socketioio/core/colors.dart';
import 'package:socketioio/data/models/chat_message/chat_message.dart';

class BubbleMessage extends StatelessWidget {
  final ChatMessage message;
  final bool itsMe;
  const BubbleMessage({super.key, required this.message, required this.itsMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: itsMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
            top: 5, bottom: 10, left: itsMe ? 60 : 15, right: itsMe ? 10 : 60),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: itsMe
              ? AppColors.secondPrimeryColor
              : AppColors.thirdPrimeryColor,
        ),
        child: Column(
          crossAxisAlignment:
              itsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!itsMe)
              Text(
                message.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.firstPrimeryColor,
                ),
              ),
            if (!itsMe)
              const SizedBox(
                height: 5,
              ),
            Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
