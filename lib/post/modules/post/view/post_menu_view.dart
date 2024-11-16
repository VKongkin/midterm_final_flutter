import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/post/view/post_profile_view.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';

class PostMenuView extends StatelessWidget {
  final viewModel = Get.put(PostViewModel());
  final BottomNavController controller = Get.find<BottomNavController>();

  PostMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Dark theme background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        toolbarHeight: 0, // Hidden AppBar
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
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings, color: Colors.white),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/post/search'); // Navigate to search screen
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Profile Card
              GestureDetector(
                onTap: () {
                  Get.to(() => PostProfileView(), transition: Transition.rightToLeft);
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
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${viewModel.firstname.value} ${viewModel.lastname.value}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Shortcuts Section
              Text(
                "Your shortcuts",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150', // Replace with actual shortcut image
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Shortcut $index",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16),

              // Options Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: [
                    _buildGridTile(Icons.access_time, "Memories"),
                    _buildGridTile(Icons.bookmark, "Saved"),
                    _buildGridTile(Icons.group, "Groups"),
                    _buildGridTile(Icons.video_call, "Video"),
                    _buildGridTile(Icons.store, "Marketplace"),
                    _buildGridTile(Icons.people, "Friends"),
                    _buildGridTile(Icons.feed, "Feeds"),
                    _buildGridTile(Icons.event, "Events"),
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
  Widget _buildGridTile(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
