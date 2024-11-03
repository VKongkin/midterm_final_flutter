import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/models/postmodel/login/login_response.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class SplashController extends GetxController{
  var _loginRepository = LoginRepository();
  var username = "";
  var storage = GetStorage();

  @override
  void onInit() {
    checkUserLoggedIn();
    super.onInit();
  }

  Future<void> checkUserLoggedIn() async {
    var user = await _loginRepository.getUserLocal();
    print("USER = ${user.user}");
    // print("USER ${storage.read("USER_KEY")["user"]["username"]}");
    if(user.user == null){
      print("NO USER FOUND");
      Future.delayed(Duration(seconds: 3));
      Get.offAllNamed(RouteName.postLogin);

    }else{
      print("USER IS NOT NULL");
      username = user.user!.username!;
      Future.delayed(Duration(seconds: 3));
      Get.offAllNamed(RouteName.postRoot);
      showCustomToast(message: "WELCOME BACK ${user.user!.username!.toUpperCase()}");
    }
  }


}