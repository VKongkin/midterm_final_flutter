import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/root_controller.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/post/widgets/post_view_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostView extends StatelessWidget {
  var viewModel = Get.put(PostViewModel());
  // final RootController rootController = Get.put(RootController());
  PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 40,  // Set the width you want
          height: 40, // Set the height you want
          child: FloatingActionButton(
            onPressed: () {
              // viewModel.onCreate();
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
                  onTab: () {
                    Get.offAllNamed(RouteName.postRoot);
                    // rootController.updateIndex(0);

                  },
                  appTitle: Constants.postAppPostManageName.tr,
                  fontSize: 17,
                  icon: Icons.arrow_back_ios,
                ),
              ),

              // The main body content inside Obx for reactive updates
              Expanded(
                child: Obx(() {
                  switch (viewModel.requestLoadingPostStatus.value) {
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
                        itemCount: viewModel.postList.length,
                        itemBuilder: (context, index) {
                          // Sort the list in descending order by 'id'
                          var sortedList = List.from(viewModel.postList)
                            ..sort((a, b) => b.id.compareTo(a.id)); // Sort by 'id' in descending order

                          var data = sortedList[index];
                          // return GestureDetector(
                          //   onTap: () {
                          //     // viewModel.onUpdate("${data.id}");
                          //   },
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     ),
                          //     child: ListTile(
                          //       leading: SizedBox(
                          //         width: 50,
                          //         height: 50,
                          //         child: CachedNetworkImage(
                          //           imageUrl: data.image != null && data.image.isNotEmpty
                          //               ? "${ApiUrl.postGetImagePath}${data.image}"
                          //               : Constants.iconNoImage,
                          //           fit: BoxFit.cover,
                          //           placeholder: (context, url) => CircularProgressIndicator(
                          //             strokeWidth: 2.0,
                          //             valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                          //           ),
                          //           errorWidget: (context, url, error) => Icon(
                          //             Icons.image_outlined,
                          //             size: 50,
                          //             color: Colors.grey,
                          //           ),
                          //         ),
                          //
                          //       ),
                          //       title: Text("${data.title}"),
                          //       subtitle: Text("${data.category.name}"),
                          //       trailing: Icon(
                          //         Icons.edit_rounded,
                          //         color: Colors.blue,
                          //       ),
                          //     ),
                          //   ),
                          // );
                          return PostViewWidget(profileImageUrl: data.user.profile != null && data.user.profile.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.user.profile}"
                              : Constants.iconNoImage, userName: data.createBy, timestamp: data.createAt, postText: data.title, postImageUrl: data.image != null && data.image.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.image}"
                              : "", likeCount: data.totalView, commentCount: 2, shareCount: 3);
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
  //   Pause on 17:47
  }
}
