import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostMenuView extends StatelessWidget {
  final viewModel = Get.put(PostViewModel()); // Initialize PostViewModel
  final RootController rootController = Get.find<RootController>();

  final BottomNavController controller =
      Get.find<BottomNavController>(); // Find BottomNavController

  PostMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // Check user role and conditionally render the buttons
    String role = rootController.userRole.value;
    bool isUser = role.contains("ROLE_USER");
    bool isAdmin = role.contains("ROLE_ADMIN");

    return Scaffold(
      backgroundColor: Color(0xFFEAECFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Constants.Menu.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showPopupMenu(context),
                          child: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      )),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName
                              .postSearch); // Navigate to search screen
                        },
                        child: const Icon(Icons.search, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Profile Card
              GestureDetector(
                onTap: () {
                  // Navigate to Profile Page
                  controller.updateIndex(2);
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          ApiUrl.postGetImagePath + viewModel.imagepath.value,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${viewModel.firstname.value} ${viewModel.lastname.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Shortcuts Section
              const Text(
                "Your shortcuts",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150', // Replace with actual shortcut image
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Shortcut $index",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // Options Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: [
                    if (isAdmin)
                      _buildGridTile(Icons.supervised_user_circle,
                          Constants.UserManage.tr, () => _gotoUserManagement()),
                    if (isAdmin)
                      _buildGridTile(Icons.category, Constants.CategoryManage.tr,
                          () => _gotoCategoryManagement()),
                    // You can uncomment the others if needed
                    // _buildGridTile(Icons.group, "Groups"),
                    // _buildGridTile(Icons.video_call, "Video"),
                    // _buildGridTile(Icons.store, "Marketplace"),
                    // _buildGridTile(Icons.people, "Friends"),
                    // _buildGridTile(Icons.feed, "Feeds"),
                    // _buildGridTile(Icons.event, "Events"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper Method for Grid Tiles
  Widget _buildGridTile(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap, // On tap functionality
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Example of the navigation function for Category Management
  void _gotoCategoryManagement() {
    print("CATEGORY MANAGEMENT");
    controller.updateIndex(1);
  }

// Example of the navigation function for User Management (if needed)
  void _gotoUserManagement() {
    Get.toNamed(RouteName.postUserManagement);
    print("USER MANAGEMENT");
  }

  void _showPopupMenu(BuildContext context) {
    final storage = GetStorage();
    var username = storage
            .read("USER_KEY")?["user"]?["username"]
            ?.toString()
            .toUpperCase() ??
        "Username";
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 90, 16, 0),
      color: Colors.white,
      items: [
        // PopupMenuItem<int>(
        //   value: 0,
        //   child: Center(
        //     child: Container(
        //       width: 120,
        //       child: Row(
        //         children: [
        //           Text(username, style: const TextStyle(color: Colors.blue)),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // const PopupMenuItem<int>(
        //   value: 1,
        //   child: Row(
        //     children: [
        //       Icon(Icons.home, color: Colors.blue),
        //       SizedBox(width: 10),
        //       Text('Home', style: TextStyle(color: Colors.blue)),
        //     ],
        //   ),
        // ),
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
        Get.toNamed(RouteName.postProfile);
      } else if (value == 1) {
        Get.offAllNamed(RouteName.postRoot);
      }
    });
  }
}
