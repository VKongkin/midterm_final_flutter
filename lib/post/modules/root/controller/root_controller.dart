import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/modules/auth/login_response.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class RootController extends GetxController {
  var selectedIndex = 0.obs;
  var userRole = "".obs;
  // final _postRepository = PostRepository();
  var storage = GetStorage();

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    _getAdminUser();
    super.onInit();
  }

  _getAdminUser(){
    // print(user.user.roles);
    if(storage.read("USER_KEY") != null){
      var user = storage.read("USER_KEY");
      if (user != null && user['user'] != null) {
        List<dynamic> roles = user['user']['roles']; // Access roles list
        userRole.value = roles.map((role) => role['name'].toString()).join(", ");
        print(userRole); // Output: ['ROLE_ADMIN']
      }
      print("TESTING ADMIN USER ${user}");
    }else{
      print("TESTING USER");
    }
  }
}
