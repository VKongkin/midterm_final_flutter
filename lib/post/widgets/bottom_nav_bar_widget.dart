import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/post/view/post_profile_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class BottomNavBarWidget extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Map<String, dynamic>> items = [
    {"icon": Icons.home, "label": "Homes", "route": RouteName.postRoot},
    {
      "icon": Icons.category_rounded,
      "label": "Category",
      "route": RouteName.postManageCategory
    },
    {
      "icon": Icons.person,
      "label": "Profile",
      "route": RouteName.postProfile
    }, // Add Profile tab
    {"icon": Icons.menu, "label": "Menu", "route": RouteName.postSearch},

  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.updateIndex(index);
          if (items[index]["route"] == RouteName.postProfile) {
            // Navigate to PostProfileView without removing BottomNavBar
            Get.to(
              () => PostProfileView(),
              transition: Transition.rightToLeft,
            );
          } else {
            // Navigate to other routes and reset the navigation stack
            Get.offAllNamed(items[index]["route"]);
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: items.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item["icon"]),
            label: item["label"],
          );
        }).toList(),
      ),
    );
  }
}
