import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/post/widgets/post_app_bar_widget.dart';
import 'package:product_flutter_app/post/widgets/post_view_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';


class PostSearchView extends StatefulWidget {
  PostSearchView({super.key});

  @override
  State<PostSearchView> createState() => _PostSearchViewState();
}

class _PostSearchViewState extends State<PostSearchView> {
  final viewModel = Get.put(PostViewModel());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            Get.offAllNamed(RouteName.postAppFormCreatePath);
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
      backgroundColor: const Color(0xFFEAECFA),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // AppBar
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: PostAppBarWidget(
                onBackTap: () {
                  Get.back();
                },
                customSearchBar: Container(
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
                          controller: searchController,
                          onChanged: (value) {
                            viewModel.onSearch(value); // Dynamic search
                          },
                          decoration: InputDecoration(
                            hintText: Constants.Search.tr,
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (searchController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0), // Adjust padding
                          child: GestureDetector(
                            onTap: () {
                              searchController.clear();
                              viewModel.onSearch(""); // Reset search
                            },
                            child: const Icon(Icons.close, color: Colors.grey, size: 20),
                          ),
                        ),
                    ],
                  ),
                ),
                fontSize: 17,
                backIcon: Icons.arrow_back_ios,
                showLanguageToggle: false,
                showProfileIcon: false,
                showSearchIcon: false,
              ),
            ),
            // Main content with posts list and loading/error handling
            Expanded(
              child: Obx(() {
                // if (viewModel.loading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                if (viewModel.postSearchList.isEmpty) {
                  return  Center(child: Text(Constants.notFound.tr));
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!viewModel.loading.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      // viewModel.loadingDataMoreSearch(searchController.text);
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      viewModel.getAllSearchPost(searchController.text); // Reload data
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 50),
                      itemCount: viewModel.postSearchList.length,
                      itemBuilder: (context, index) {
                        var data = viewModel.postSearchList[index];
                        return PostViewWidget(
                          profileImageUrl: data.user!.profile != null && data.user!.profile!.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.user!.profile}"
                              : Constants.iconNoImage,
                          userName: data.createBy!,
                          firstName: data.user!.firstName!,
                          lastName: data.user!.lastName!,
                          timestamp: data.createAt!,
                          postText: data.description!,
                          postImageUrl: data.image != null && data.image!.isNotEmpty
                              ? "${ApiUrl.postGetImagePath}${data.image}"
                              : "",
                          likeCount: data.totalView!,
                          commentCount: 2,
                          shareCount: 3,
                          postTitle: data.title!,
                          postId: data.id!,
                          onTapEdit: () {
                            setState(() {
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
