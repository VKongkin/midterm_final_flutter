import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/widgets/user_screen_widget.dart';

class UserManagementView extends StatelessWidget {
  final viewModel = Get.put(PostViewModel());
  final RootController rootController = Get.find<RootController>();
  final PostViewModel controller = Get.find<PostViewModel>();
  UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          title: Container(
            height: 30, // Fixed height for consistency
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    controller: viewModel.searchController,
                    onChanged: (value) {
                      viewModel.filterUsersList(value); // Dynamic search
                    },
                    decoration: InputDecoration(
                      hintText: Constants.Search.tr,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (viewModel.searchController.value.text.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 12.0), // Adjust padding
                    child: GestureDetector(
                      onTap: () {
                        viewModel.searchController.clear();
                        viewModel.onSearch(""); // Reset search
                      },
                      child:
                          const Icon(Icons.close, color: Colors.grey, size: 20),
                    ),
                  ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(child: Obx(() {
          if (viewModel.loadingScreen.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFEAECFA), // Background color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and "Find Friends" button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "USERS MANAGEMENT",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${controller.filteredUsersList.length} users",
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Friends count
                    const SizedBox(height: 8),
                    // Friends grid
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Three columns
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 4, // Rectangle profile cards
                      ),
                      itemCount:
                          controller.filteredUsersList.length, // Limit to 6 items
                      itemBuilder: (context, index) {
                        final friend = controller.filteredUsersList[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.onUpdateProfileUser(friend.id!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[500], // Card background color
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey[600]!, width: 1),
                            ),
                            child: Column(
                              children: [
                                // Profile Picture with error handling
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ), // Rounded corners
                                  child: friend.profile != null
                                      ? Image.network(
                                          ApiUrl.postGetImagePath +
                                              friend.profile!,
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) {
                                              return child; // Display image when loaded
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: progress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? progress
                                                              .cumulativeBytesLoaded /
                                                          (progress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                                height: 120,
                                                width: double.infinity,
                                                color: Colors.grey[400],
                                                child: Image.asset(
                                                  "assets/images/icons/no_user.jpg",
                                                  fit: BoxFit.cover,
                                                ));
                                          },
                                        )
                                      : Container(
                                          height: 120,
                                          width: double.infinity,
                                          color: Colors.grey[400],
                                          child: Image.asset(
                                            "assets/images/icons/no_user.jpg",
                                            fit: BoxFit.cover,
                                          )),
                                ),
                                const SizedBox(height: 8),
                                // Friend Name
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    friend.username!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    // "See All Friends" Button
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.grey[500],
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   child: const Center(
                    //     child: Text(
                    //       "See all users",
                    //       style: TextStyle(color: Colors.white, fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          );
        })));
  }
}
