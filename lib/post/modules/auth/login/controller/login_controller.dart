import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/data/app_exceptions.dart';
import 'package:product_flutter_app/models/postmodel/login/login_request.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var loadingLogin = false.obs;
  final _loginRepository = LoginRepository();

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
      var response = await _loginRepository.login(
        phoneNumber: usernameController.value.text,
        password: passwordController.value.text,
      );
      Get.offAllNamed(RouteName.postSplash);
      _loginRepository.saveUserLocal(response);
    } on UnAuthorization {
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
