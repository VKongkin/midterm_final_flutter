import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/modules/root/view/root_view.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../category/view/post_category_view.dart';

class MainWrapper extends StatelessWidget {
  final RootController rootController = Get.put(RootController());

  MainWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to manage different pages
      body: Obx(() {
        return IndexedStack(
          index: rootController.selectedIndex.value,
          children: [
            RootView(), // Home view
            PostCategoryView(), // Category view
            PostView(), // Post view
          ],
        );
      }),

      // Centered FloatingActionButton
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     rootController.updateIndex(1); // Set index to 1 (middle button)
      //   },
      //   backgroundColor: Colors.green,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.shopping_cart, color: Colors.white, size: 28), // Ensure icon size fits well
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(icon: Icon(Icons.home), onPressed: () {}),
                IconButton(icon: Icon(Icons.sunny_snowing), onPressed: () {}),
                SizedBox(width: 50), // Spacer for the FloatingActionButton
                IconButton(icon: Icon(Icons.category), onPressed: () {}),
                IconButton(icon: Icon(Icons.person), onPressed: () {}),
              ],
            ),
          ),
          // FloatingActionButton with a circular background
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 56.0, // Same height and width to make it circular
              width: 56.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green, // Background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3), // Controls shadow positioning
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  rootController
                      .updateIndex(1); // Set index to 1 (middle button)
                },
                backgroundColor: Colors.green,
                shape: const CircleBorder(),
                child: const Icon(Icons.shopping_cart,
                    color: Colors.white,
                    size: 28), // Ensure icon size fits well
              ),
            ),
          ),
        ],
      ),
    );
  }
}
