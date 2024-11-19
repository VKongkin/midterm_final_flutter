import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/post/modules/category/view_model/post_category_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostCategoryView extends StatelessWidget {
  var viewModel = Get.put(PostCategoryViewModel());
  final RootController rootController = Get.put(RootController());

  final BottomNavController controller = Get.find<BottomNavController>();
  PostCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Check user role and conditionally render the buttons
    String role = rootController.userRole.value;
    bool isUser = role.contains("ROLE_USER");
    bool isAdmin = role.contains("ROLE_ADMIN");

    return Scaffold(
      floatingActionButton: isAdmin
          ? SizedBox(
              width: 40, // Set the width you want
              height: 40, // Set the height you want
              child: FloatingActionButton(
                onPressed: () {
                  viewModel.onCreate();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 20, // You can also adjust the icon size separately
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            )
          : null, // Hide the FloatingActionButton if the user is not an admin
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: const Color(0xFFEAECFA),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Add the PostAppBarWidget at the top of the column
            Container(
              color: Colors.blue, // Your desired color for the background
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: PostAppBarWidget(
                onBackTap: () {
                  controller.updateIndex(0);
                },
                appTitle: Constants.postAppCategoryManageName.tr,
                fontSize: 17,
                backIcon: Icons.grid_view_rounded,
                onSearchTap: (){
                  Get.toNamed(RouteName.postSearch);
                },
              ),
            ),

            // The main body content inside Obx for reactive updates
            isAdmin
                ? Expanded(
                    child: Obx(() {
                      switch (viewModel.loadingRequestAllCategoryStatus.value) {
                        case Status.loading:
                          return Center(
                            child: Text("Loading the data..."),
                          );
                        case Status.error:
                          return Center(
                            child: Text("Error..."),
                          );
                        case Status.completed:
                          return RefreshIndicator(
                              onRefresh: () async {
                                viewModel.loadingCategoryData();
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 50),
                                itemCount: viewModel.categoryList.length,
                                itemBuilder: (context, index) {
                                  var sortedList = List.from(viewModel.categoryList)
                                    ..sort((a, b) =>
                                        b.id.compareTo(a.id)); // Sort by 'id'

                                  var data = sortedList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.onUpdate("${data.id}");
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 16, right: 16),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: ListTile(
                                        title: Text("${data.name}"),
                                        trailing: const Icon(
                                          Icons.edit_rounded,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                        default:
                          return const SizedBox
                              .shrink(); // Handle unexpected statuses
                      }
                    }),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.red,
                              width: 3,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                            height: 16), // Spacing between the icon and text
                        const Text(
                          "Unauthorized",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
