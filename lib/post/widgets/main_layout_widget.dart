import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';

class MainLayoutWidget extends StatelessWidget {
  final Widget child;
  final bool showBottomNav;

  MainLayoutWidget({required this.child, this.showBottomNav = true});

  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomNav
          ? Obx(
              () => BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: (index) {
                  controller.updateIndex(index);
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.video_call), label: "Video"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: "Friends"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store), label: "Marketplace"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: "Notifications"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Menu"),
                ],
              ),
            )
          : null, // Hide the navigation bar if `showBottomNav` is false
    );
  }
}
