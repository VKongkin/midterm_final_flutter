import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_response.dart';
import 'package:product_flutter_app/models/postmodel/post_category.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class PostCategoryFormViewModel extends GetxController {
  var categoryNameController = TextEditingController().obs;
  var onCreateLoading = false.obs;
  var postRepository = PostRepository();
  var categoryRequest = PostCategory().obs;
  var requestLoadingCategory = Status.loading.obs;
  void setRequestLoadingCategory(Status value) =>
      requestLoadingCategory.value = value;

  @override
  void onInit() {
    _getCategoryById();
    super.onInit();
  }

  _getCategoryById() async {
    try {
      int id = int.parse(Get.parameters["id"] ?? "0");
      categoryRequest.value.id = id;
      if (id != 0) {
        setRequestLoadingCategory(Status.loading);
        var baseRequest = BasePostRequest(id: id);
        var response = await postRepository.getCategoryById(baseRequest);

        if (response.code == "SUC-000") {
          categoryRequest.value = PostCategory.fromJson(response.data);
          categoryNameController.value.text = categoryRequest.value.name ?? "";
        }
      }
    }finally{
      setRequestLoadingCategory(Status.completed);
    }
  }
  onCreateCategory() async {
    try {
      onCreateLoading(true);
      print("On create");
      if (categoryNameController.value.text.isEmpty) {
        showCustomToast(message: "Please enter category name");
        return;
      }

      categoryRequest.value.name = categoryNameController.value.text;
      categoryRequest.value.status = "ACT";
      var response =
          await postRepository.createPostCategories(categoryRequest.value);
      if (response.code == "SUC-000") {
        print("Updated or Created");
        Get.back(result: true);
      } else {
        showCustomToast(message: response.message ?? "");
      }
    } finally {
      onCreateLoading(false);
    }
  }
}
