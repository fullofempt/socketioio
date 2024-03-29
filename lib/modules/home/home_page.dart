import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socketioio/core/colors.dart';
import 'package:socketioio/modules/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.firstPrimeryColor,
        appBar: AppBar(
          title: const Text(
            'Вход',
            style: TextStyle(
                color: AppColors.firstPrimeryColor,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondPrimeryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Укажите ваш ник!",
                style: TextStyle(
                    fontSize: 24, color: AppColors.secondPrimeryColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                cursorColor: AppColors.secondPrimeryColor,
                controller: controller.textCtrl,
                onSubmitted: (value) => controller.signIn(),
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  
                  filled: true,
                ),
              ),
            ],
          ),
        ));
  }
}
