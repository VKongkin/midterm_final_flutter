import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_menu_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_profile_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class MainWrapper extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Map<String, dynamic>> navItems = [
    {"icon": Icons.home, "label": "Home", "route": RouteName.postRoot},
    {
      "icon": Icons.category_rounded,
      "label": "Category",
      "route": RouteName.postManageCategory,
    },
    {"icon": Icons.person, "label": "Profile", "route": RouteName.postProfile},
    {"icon": Icons.menu, "label": "Menu", "route": RouteName.postMenu},
  ];

  final Map<String, Widget> routePages = {
    RouteName.postRoot: PostView(),
    RouteName.postManageCategory: PostCategoryView(),
    RouteName.postProfile: PostProfileView(),
    RouteName.postMenu: PostMenuView(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Dynamically render the current page with a unique Key
        final currentRoute = navItems[controller.currentIndex.value]['route'];
        return KeyedSubtree(
          key: ValueKey(currentRoute), // Add a unique key for each route
          child: routePages[currentRoute] ?? PostView(),
        );
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            // Update currentIndex
            controller.updateIndex(index);

            // Navigate to the selected page
            final selectedRoute = navItems[index]['route'];
            Get.offNamed(
              selectedRoute,
              id: 1,
            );
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: navItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item["icon"]),
              label: item["label"],
            );
          }).toList(),
        ),
      ),
    );
  }
}
