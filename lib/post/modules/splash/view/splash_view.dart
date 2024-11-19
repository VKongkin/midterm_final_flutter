import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/splash/controller/splash_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class SplashView extends StatefulWidget {

  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  final splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    print("INIT STATE");
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Future.delayed(const Duration(seconds: 3),(){
    //   Get.offAllNamed(RouteName.postRoot);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }

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
