import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/splash/controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  final splashController = Get.put(SplashController());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: splashController.scaleAnimation, // Apply scale animation here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view_rounded,
                color: Colors.blue,
                size: 120,
              ),
              Text("FREE POST APPLICATION",style: TextStyle(
                color: Colors.blue,
                fontSize: 15
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
