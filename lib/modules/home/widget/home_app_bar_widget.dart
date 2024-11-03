import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/post/modules/auth/login/controller/login_controller.dart';
import 'package:product_flutter_app/post/modules/splash/controller/splash_controller.dart';
import 'package:product_flutter_app/repository/auth_repository.dart';
import 'package:product_flutter_app/repository/post/login_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class HomeAppBarWidget extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final AuthRepository authRepository = Get.put(AuthRepository());

  HomeAppBarWidget({super.key, });

  Future<String?> _fetchCachedImagePath() async {
    return await authRepository.getCachedImagePath();
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    return Container(
      color: Colors.blue,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 32, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(RouteName.shimmerLoading);
              },
              icon: Icon(Icons.grid_view_rounded),
              color: Colors.white,
              style: IconButton.styleFrom(iconSize: 32),
            ),
            Text(
              Constants.appName.tr,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: Colors.white,
                    style: IconButton.styleFrom(iconSize: 32),
                  ),
                  InkWell(
                    onTap: () {
                      if (storage.read("KEY_LANGUAGE") == "KH") {
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);
                        storage.write("KEY_LANGUAGE", "US");
                      } else {
                        var locale = Locale('km', 'KH');
                        Get.updateLocale(locale);
                        storage.write("KEY_LANGUAGE", "KH");
                      }
                    },
                    child: Image.asset(
                      storage.read("KEY_LANGUAGE") == "KH"
                          ? Constants.iconKhmerPath
                          : Constants.iconEnglishPath,
                      height: 27,
                      width: 27,
                    ),
                  ),
                  // Fetch the cached image path when the login button is pressed
                  // IconButton(
                  //   onPressed: () async {
                  //     // Call the onPressLogin function
                  //     onPressLogin();
                  //
                  //     // Fetch the cached image after a successful login
                  //     String? imagePath = await _fetchCachedImagePath();
                  //     if (imagePath != null) {
                  //       // Update your UI to display the new image (you may need to call setState or use a state management solution)
                  //     }
                  //   },
                  //   icon: FutureBuilder<String?>(
                  //     future: _fetchCachedImagePath(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return CircularProgressIndicator(); // Show loading indicator
                  //       } else if (snapshot.hasError || !snapshot.hasData) {
                  //         return Icon(Icons
                  //             .account_circle); // Show default icon if no cached image
                  //       } else {
                  //         String? imagePath = snapshot.data;
                  //         if (imagePath != null) {
                  //           return Image.file(
                  //             File(imagePath), // Load image from local file
                  //             width: 32,
                  //             height: 32,
                  //           );
                  //         } else {
                  //           return Icon(Icons
                  //               .account_circle); // Fallback if image is not cached
                  //         }
                  //       }
                  //     },
                  //   ),
                  //   color: Colors.white,
                  //   style: IconButton.styleFrom(iconSize: 32),
                  // ),
                  IconButton(
                    onPressed: () {
                      _showPopupMenu(context);
                    },
                    icon: Icon(Icons.account_circle_rounded),
                    color: Colors.white,
                    style: IconButton.styleFrom(iconSize: 32),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to display the dropdown menu
  void _showPopupMenu(BuildContext context) {
    final storage = GetStorage();
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 16, 0),
      color: Colors.white, // Adjust the position as needed
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Container(
            width: 100, // Adjust width here
            child: Row(
              children: [
                // Icon(Icons.home, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "Username",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Container(
            width: 100, // Adjust width here
            child: Row(
              children: [
                Icon(Icons.home, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Home',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: 100, // Adjust width here
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Cart',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Container(
            width: 100, // Adjust width here
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 4,
          child: Container(
            width: 100, // Adjust width here
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Log Out',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        // Handle menu selection here
        switch (value) {
          case 1:
            print("Home selected");
            break;
          case 2:
            print("Share selected");
            break;
          case 3:
            print("Settings selected");
            break;
          case 4:
            print("Log Out selected");
            storage.remove("USER_KEY");
            Get.offAllNamed(RouteName.postSplash);
            break;
        }
      }
    });
  }
}
