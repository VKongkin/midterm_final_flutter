import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  List<Map<String, dynamic>> getNavItems() {
    bool isUser = userRole.value.contains("ROLE_USER");
    bool isAdmin = userRole.value.contains("ROLE_ADMIN");

    return [
      if (isUser) {"icon": Icons.home, "label": "Home", "route": RouteName.postRoot},
      if (isAdmin) {
        "icon": Icons.category_rounded,
        "label": "Category",
        "route": RouteName.postManageCategory,
      },
      {"icon": Icons.person, "label": "Profile", "route": RouteName.postProfile},
      if (isUser) {"icon": Icons.menu, "label": "Menu", "route": RouteName.postMenu},
    ];
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
