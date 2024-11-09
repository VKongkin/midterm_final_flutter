import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/home/widget/home_app_bar_widget.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/widgets/custom_bottom_app_bar_screen.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class RootView extends StatelessWidget {
  final RootController rootController = Get.put(RootController());
  RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAECFA),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: PostAppBarWidget(
                onTab: () {
                  // Add your logic here if needed
                },
                appTitle: Constants.postAppName.tr,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.postManagePath);
                        // rootController.updateIndex(2);

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF13408C), Colors.blue, Color(0xFF13408c)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.postManageCategory);
                        // rootController.updateIndex(1);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF13408C), Colors.blue, Color(0xFF13408c)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              width: double.infinity,
              child:
              Obx(() {
                // Check user role and conditionally render the buttons
                String role = rootController.userRole.value;
                bool isUser = role.contains("ROLE_USER");
                bool isAdmin = role.contains("ROLE_ADMIN");

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (isUser) // Show USER button if the role is ROLE_USER
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle USER button tap
                            print("USER Button Tapped");
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF13408C),
                                  Colors.blue,
                                  Color(0xFF13408c)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "USER",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (isUser && isAdmin) SizedBox(width: 10), // Space between buttons
                    if (isAdmin) // Show ADMIN button if the role is ROLE_ADMIN
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle ADMIN button tap
                            print("ADMIN Button Tapped");
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16,left: 16),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF13408C),
                                  Colors.blue,
                                  Color(0xFF13408c)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "ADMIN",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

