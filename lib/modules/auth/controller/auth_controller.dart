import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:product_flutter_app/main.dart';
import 'package:product_flutter_app/modules/auth/login_request.dart';
import 'package:product_flutter_app/repository/auth_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class AuthController extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var loadingLogin = false.obs;
  var authRepository = AuthRepository();

  Future<void> login() async {
    if (usernameController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Username");
      return;
    }

    if (passwordController.value.text.isEmpty) {
      showCustomToast(message: "Please Enter Your Password");
      return;
    }

    loadingLogin(true);

    try {
      var req = LoginRequest(
        username: usernameController.value.text,
        password: passwordController.value.text,
      );
        await authRepository
          .login(req); //Wait to make repository again time 40:17
      Get.offAllNamed(RouteName.homeScreen);
    } on UnauthorizedException {
      showCustomToast(message: "Username or Password Invalid!");
    }
    // catch (e) {
    //   showCustomToast(message: e.toString());
    // }
    finally {
      loadingLogin(false);
    }
  }


}
