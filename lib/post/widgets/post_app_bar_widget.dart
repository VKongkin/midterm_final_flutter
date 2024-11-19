import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostAppBarWidget extends StatelessWidget {
  final String? appTitle;
  final double? fontSize;
  final VoidCallback? onBackTap;
  final IconData? backIcon;
  final bool showSearchIcon;
  final bool showLanguageToggle;
  final bool showProfileIcon;
  final VoidCallback? onSearchTap;
  final VoidCallback? onLanguageToggleTap;
  final VoidCallback? onProfileTap;
  final Widget? customSearchBar;
  final double? iconSize;

  const PostAppBarWidget({
    Key? key,
    this.appTitle,
    this.fontSize,
    this.onBackTap,
    this.backIcon,
    this.showSearchIcon = true,
    this.showLanguageToggle = true,
    this.showProfileIcon = true,
    this.onSearchTap,
    this.onLanguageToggleTap,
    this.onProfileTap,
    this.customSearchBar,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    return Container(
      color: Colors.blue,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back Button
          if (onBackTap != null)
            IconButton(
              onPressed: onBackTap,
              icon: Icon(backIcon ?? Icons.arrow_back_ios, color: Colors.white,size: iconSize == 30 ? iconSize: 30,),
            ),

          // Title or Custom Search Bar
          if (customSearchBar != null)
            Expanded(
              child: customSearchBar!,
            )
          else
            Expanded(
              child: Text(
                appTitle ?? "",
                style: TextStyle(
                  fontSize: fontSize ?? 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

          // Right-side Icons
          if (customSearchBar == null) ...[
            if (showSearchIcon)
              IconButton(
                onPressed: onSearchTap,
                icon: Icon(Icons.search, color: Colors.white,size: iconSize == 30 ? iconSize: 30,),
              ),
            if (showLanguageToggle)
              GestureDetector(
                onTap: onLanguageToggleTap ??
                        () {
                      if (storage.read("KEY_LANGUAGE") == "KH") {
                        var locale = const Locale('en', 'US');
                        Get.updateLocale(locale);
                        storage.write("KEY_LANGUAGE", "US");
                      } else {
                        var locale = const Locale('km', 'KH');
                        Get.updateLocale(locale);
                        storage.write("KEY_LANGUAGE", "KH");
                      }
                    },
                child: Image.asset(
                  storage.read("KEY_LANGUAGE") == "KH"
                      ? Constants.iconKhmerPath
                      : Constants.iconEnglishPath,
                  height: 25,
                  width: 25,
                ),
              ),
            if (showProfileIcon)
              IconButton(
                onPressed: onProfileTap ?? () => _showPopupMenu(context),
                icon: Icon(Icons.account_circle_rounded, color: Colors.white,size: iconSize == 30 ? iconSize: 30,),
              ),
          ],
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    final BottomNavController controller = Get.find<BottomNavController>();
    final storage = GetStorage();
    var username = storage.read("USER_KEY")?["user"]?["username"]?.toString().toUpperCase() ?? "Username";
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 16, 0),
      color: Colors.white,
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Center(
            child: Container(
              width: 120,
              child: Row(
                children: [
                  Text(username, style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.home, color: Colors.blue),
              SizedBox(width: 10),
              Text('Home', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        const PopupMenuItem<int>(
          value: 4,
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.blue),
              SizedBox(width: 10),
              Text('Log Out', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 4) {
        storage.remove("USER_KEY");
        Get.offAllNamed(RouteName.postLogin);
      } else if (value == 0) {
        print("GO TO PF");
        controller.updateIndex(2);
      } else if (value == 1) {
        Get.offAllNamed(RouteName.postRoot);
      }
    });
  }
}
