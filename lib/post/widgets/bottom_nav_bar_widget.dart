import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class BottomNavBarWidget extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Map<String, dynamic>> items = [
    {"icon": Icons.home, "label": "Home", "route": RouteName.postRoot},
    {"icon": Icons.video_call, "label": "Video", "route": RouteName.postManageCategory},
    {"icon": Icons.people, "label": "Friends", "route": RouteName.postManagePath},
    {"icon": Icons.store, "label": "Marketplace", "route": RouteName.postAppFormCreatePath},
    {"icon": Icons.notifications, "label": "Notifications", "route": RouteName.postManageCreateCategoryPath},
    {"icon": Icons.menu, "label": "Menu", "route": RouteName.postSearch},
    {"icon": Icons.person, "label": "Profile", "route": RouteName.postProfile}, // New Profile tab
  ];


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.updateIndex(index);
          Get.offAllNamed(
              items[index]["route"]); // Navigate using the route name
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
