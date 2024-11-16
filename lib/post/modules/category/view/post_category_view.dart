import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/post/modules/category/view_model/post_category_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostCategoryView extends StatelessWidget {
  var viewModel = Get.put(PostCategoryViewModel());
  final RootController rootController = Get.put(RootController());
  PostCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 40,  // Set the width you want
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Color(0xFFEAECFA),
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
                    Get.offNamed(RouteName.postRoot);
                    // rootController.updateIndex(0);
                  },
                  appTitle: Constants.postAppCategoryManageName.tr,
                  fontSize: 17,
                  backIcon: Icons.arrow_back_ios,
                ),
              ),

              // The main body content inside Obx for reactive updates
              Expanded(
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
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 50),
                        itemCount: viewModel.categoryList.length,
                        itemBuilder: (context, index) {
                          // Sort the list in descending order by 'id'
                          var sortedList = List.from(viewModel.categoryList)
                            ..sort((a, b) => b.id.compareTo(a.id)); // Sort by 'id' in descending order

                          var data = sortedList[index];
                          return GestureDetector(
                            onTap: () {
                              viewModel.onUpdate("${data.id}");
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text("${data.name}"),
                                trailing: Icon(
                                  Icons.edit_rounded,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          );
                        },
                      );

                    default:
                      return SizedBox.shrink(); // Handle unexpected statuses
                  }
                }),
              ),
            ],
          ),
        )
    );
  }
}
