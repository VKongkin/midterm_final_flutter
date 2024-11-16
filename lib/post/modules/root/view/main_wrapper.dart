import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_form_widget_view.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_form_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_menu_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_search_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/post/modules/root/view/root_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_profile_view.dart';

class MainWrapper extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    PostView(), // Replace with your actual screens
    PostCategoryView(),
    PostFormView(),
    RootView(),
    PostCategoryFormWidgetView(),
    PostMenuView(),
    PostProfileView(), // Add PostProfileView to the list of pages
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.updateIndex, // Update the active index
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            if (index == 6) {
              // Navigate to the profile page
              controller.navigateToProfile();
            } else {
              controller.changePage(index); // Navigate to other tabs
            }
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Video"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friends"),
            BottomNavigationBarItem(
                icon: Icon(Icons.store), label: "Marketplace"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notifications"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ],
        ),
      ),
    );
  }
}
