import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/post/modules/splash/controller/splash_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostAppBarWidget extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());
  var splashController = SplashController();

  // final AuthRepository authRepository = Get.put(AuthRepository());
  String? appTitle;
  VoidCallback? onTab;
  IconData? icon;
  double? fontSize;
  PostAppBarWidget({super.key, this.onTab, this.appTitle, this.icon, this.fontSize});

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
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: onTab,
                    icon: Icon(icon ?? Icons.grid_view_rounded),
                    color: Colors.white,
                    style: IconButton.styleFrom(iconSize: 32),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    appTitle??"",
                    style: TextStyle(
                        fontSize: fontSize??15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
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
    var username = storage.read("USER_KEY")["user"]["username"].toString().toUpperCase();
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
                  username != null ? username : "Username",
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
