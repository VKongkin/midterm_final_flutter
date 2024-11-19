import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/post/widgets/post_view_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostView extends StatefulWidget {
  PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final viewModel = Get.put(PostViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            viewModel.onCreate();
          },
          child: Icon(
            Icons.add,
            color: Colors.blue,
            size: 20,
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
            // AppBar
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: PostAppBarWidget(
                backIcon: Icons.grid_view_rounded,
                onBackTap: () {
                  // Get.back();
                },
                appTitle: Constants.postAppName.tr,
                fontSize: 17,
                onSearchTap: (){
                  Get.toNamed(RouteName.postSearch);
                },
                iconSize: 25,
              ),
            ),

            // Main content with posts list and loading/error handling
            Expanded(
              child: Obx(() {
                // if (viewModel.loading.value) {
                //   return Center(child: Text("Loading the data..."));
                // }

                // Display completed state if not loading or error
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!viewModel.loading.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      viewModel.loadingDataMore();
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      viewModel.getAllPost();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 50),
                      itemCount: viewModel.postList.length,
                      itemBuilder: (context, index) {
                        var data = viewModel.postList[index];
                        return PostViewWidget(
                          profileImageUrl: data.user!.profile != null && data.user!.profile!.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.user!.profile}"
                              : Constants.iconNoImage,
                          userName: data.createBy!,
                          timestamp: data.createAt!,
                          firstName: data.user!.firstName!,
                          lastName: data.user!.lastName!,
                          postText: data.description!,
                          postImageUrl: data.image != null && data.image!.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.image}"
                              : "",
                          likeCount: data.totalView!,
                          commentCount: 2,
                          shareCount: 3,
                          postId: data.id!,
                          postTitle: data.title!,
                          onTapEdit: (){
                            setState(() {
                              print("object");
                              viewModel.onUpdate(data.id.toString());
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
