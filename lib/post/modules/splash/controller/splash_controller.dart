import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/models/postmodel/login/login_response.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin{
  var _loginRepository = LoginRepository();
  var username = "";
  var storage = GetStorage();
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    checkUserLoggedIn();
    super.onInit();

    // Initialize the AnimationController
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Define a scale animation
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Start the animation when the controller is initialized
    animationController.forward();

    // Navigate to the next screen after 3 seconds
    // Future.delayed(Duration(seconds: 3), () {
    //   Get.offAllNamed(RouteName.postMainWrapper); // Replace '/home' with your actual route name
    // });
  }

  @override
  void onClose() {
    // Dispose the animation controller when done
    animationController.dispose();
    super.onClose();
  }


  Future<void> checkUserLoggedIn() async {
    var user = await _loginRepository.getUserLocal();
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? false;
    print("CHECK LAUNCH ${isFirstLaunch}");

    if (isFirstLaunch == true) {
      // Display the splash screen animation for the first launch
      await Future.delayed(Duration(seconds: 2)); // Display for 3 seconds
      prefs.setBool('isFirstLaunch', false); // Update to mark as not first launch
    }
    if (user.user == null) {
      print("NO USER FOUND");
      await Future.delayed(Duration(seconds: 2));  // Await the delay to pause execution
      Get.offAllNamed(RouteName.postLogin);
      return;
    } else {
      print("USER IS NOT NULL");
      username = user.user!.username!;
      await Future.delayed(Duration(seconds: 2));  // Await the delay to pause execution
      Get.offAllNamed(RouteName.postMainWrapper);
      showCustomToast(message: "WELCOME BACK ${user.user!.username!.toUpperCase()}");
    }

  }


}