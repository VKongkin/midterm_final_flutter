import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/modules/root/controller/bottom_nav_controller.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/post/widgets/post_view_widget.dart';
import 'package:product_flutter_app/post/widgets/profile_screen_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostProfileView extends StatefulWidget {
  PostProfileView({super.key});



  @override
  State<PostProfileView> createState() => _PostProfileViewState();
}



class _PostProfileViewState extends State<PostProfileView> {
  final BottomNavController controller = Get.find<BottomNavController>();
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
      body: Obx((){
        if(viewModel.loadingScreen.value){
          return CircularProgressIndicator();
        }
        return SafeArea(
          top: false,
          child: Column(
            children: [
              // AppBar
              Container(
                color: Colors.blue,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: PostAppBarWidget(
                  onBackTap: () {
                    controller.updateIndex(0);
                  },
                  appTitle: Constants.Profile.tr,
                  fontSize: 16,
                  backIcon: Icons.grid_view_rounded,
                  onSearchTap: (){
                    Get.toNamed(RouteName.postSearch);
                  },
                ),
              ),
              // Main content with posts list and loading/error handling
              Expanded(
                child: Obx(() {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!viewModel.loading.value &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        viewModel.loadingDataMoreProfilePost();
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        viewModel.getAllProfilePost();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 50),
                        itemCount: viewModel.postProfileList.length +
                            1, // Add 1 for ProfileScreenWidget
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ProfileScreenWidget(
                              userId: viewModel.userId,
                              firstName: viewModel.firstname.value,
                              lastName: viewModel.lastname.value,
                              imagePath: viewModel.imagepath.value,
                              username: viewModel.username.value,
                              phoneNumber: viewModel.phoneNumber.value,
                              email: viewModel.email.value,
                              onEditTap: (){
                                viewModel.onUpdateProfileUser(viewModel.userId);
                              },
                            ); // Add ProfileScreenWidget at the top
                          } else {
                            var data = viewModel.postProfileList[index - 1];
                            return PostViewWidget(
                              profileImageUrl: data.user!.profile != null &&
                                  data.user!.profile!.isNotEmpty
                                  ? "${ApiUrl.postGetImagePath}${data.user!.profile}"
                                  : Constants.iconNoImage,
                              userName: data.createBy!,
                              firstName: data.user!.firstName!,
                              lastName: data.user!.lastName!,
                              timestamp: data.createAt!,
                              postText: data.description!,
                              postImageUrl:
                              data.image != null && data.image!.isNotEmpty
                                  ? "${ApiUrl.postGetImagePath}${data.image}"
                                  : "",
                              likeCount: data.totalView!,
                              commentCount: 2,
                              shareCount: 3,
                              postId: data.id!,
                              postTitle: data.title!,
                              onTapEdit: () {
                                setState(() {
                                  print("Edit tapped");
                                  viewModel.onUpdate(data.id.toString());
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      })


    );
  }
}
