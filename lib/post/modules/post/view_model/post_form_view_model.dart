import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_category.dart';
import 'package:product_flutter_app/post/modules/post/Post_request.dart';
import 'package:product_flutter_app/post/modules/post/category.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class PostFormViewModel extends GetxController {
  final PostRepository _postRepository = PostRepository();

  RxString filenameUploaded = "".obs;
  var postTitleController = TextEditingController().obs;
  var postDescriptionController = TextEditingController().obs;
  var postStatusController = TextEditingController().obs;
  var postCategoryController = TextEditingController().obs;
  var postRepository = PostRepository();
  var postRequest = PostRequest().obs;
  var onCreateLoading = false.obs;
  var requestLoadingPost = Status.loading.obs;
  var imageFilePath = "".obs;
  var createdByUser = "".obs;
  File? selectedImage;
  void setRequestLoadingPost(Status value) => requestLoadingPost.value = value;
  var storage = GetStorage();

  // Category data
  var categories = <PostCategory>[].obs; // List of PostCategory objects
  var selectedCategory = Rx<PostCategory?>(null); // Selected category
  var testCategory = Rx<PostCategory?>(null); // Selected category
  var selectedStatus = "".obs;

  @override
  Future<void> onInit() async {
    await _getPostById();
    super.onInit();
    loadCategories(); // Load categories on init
  }

  getImagePath(String imagePath)
  {
    ApiUrl.postGetImagePath+imagePath;
  }
  _getPostById() async{
    try{
      int id = int.parse(Get.parameters["id"]??"0");
      postRequest.value.id = id;
      if(id!=0){
        var baseRequest = BasePostRequest(status:"ACT",id: id);
        var response = await postRepository.getAllPostsById(baseRequest);

        if(response.code == "SUC-000"){
          postRequest.value = PostRequest.fromJson(response.data);
          postTitleController.value.text = postRequest.value.title ?? "";
          postDescriptionController.value.text = postRequest.value.description ?? "";
          postStatusController.value.text = postRequest.value.status ?? "";
          imageFilePath.value = postRequest.value.image!;
          createdByUser.value = postRequest.value.createBy ?? "";
          // postCategoryController.value = postRequest.value.category as TextEditingController;
          // postCategoryController.value.text = selectedCategory.value?.name ?? "";
          selectedCategory.value = PostCategory(
            id: postRequest.value.category?.id,
            name: postRequest.value.category?.name,
            status: postRequest.value.category?.status,
            createAt: postRequest.value.category?.createAt,
            createBy: postRequest.value.category?.createBy,
            imageUrl: postRequest.value.category?.imageUrl,
            updateAt: postRequest.value.category?.updateAt,
            updateBy: postRequest.value.category?.updateBy,
          );
          print(selectedCategory.value!.toJson());

        //   Select category update is still not working
        }
      }
    }finally{

    }
  }

  void loadCategories() {
    // TODO: Fetch categories from your data source (e.g., API or local storage)
    // Mock data for now
    categories.value = [
      PostCategory(id: 1, name: 'Technology', status: 'ACT'),
      PostCategory(id: 2, name: 'Sports', status: 'ACT'),
      // Add more categories as needed
    ];
  }

  onCreateOrUpdatePost(int id) async {
    print("FILE NAME FROM CREATE ${filenameUploaded} AND ID: ${id}");
    var userData = storage.read("USER_KEY");
    var user = userData['user'];
    var userName = user['username'];
    var createUser = "".obs;
    print(selectedStatus.value);
    print(imageFilePath);
    if(postDescriptionController.value.text.isEmpty){
      showCustomToast(message: "Please Input Description");
      return;
    }

    // if(selectedStatus.value.isEmpty){
    //   showCustomToast(message: "Please Select Status");
    //   return;
    // }

    // Set the selected category in postRequest
    if (selectedCategory.value == null) {
      showCustomToast(message: "Please Select Category");
      return;
    }

    if(postRequest.value.id != 0){
      createUser.value = createdByUser.value;
      if(selectedImage==null){
        filenameUploaded.value = imageFilePath.value;
        print(filenameUploaded);
      }
    }else{
      createUser.value = userName;
    }

    try {
      onCreateLoading(true);

      if(selectedImage != null) {
        await uploadImage(selectedImage!);
      }else{
        if(postRequest.value.id != 0){
            filenameUploaded.value = imageFilePath.value;
            print(filenameUploaded);

        }else{
          filenameUploaded.value = "NON";
        }
      }
      // postRequest.value.status = "ACT";
      postRequest.value.createAt = "";
      postRequest.value.image = filenameUploaded.value;
      postRequest.value.updateAt = "";
      postRequest.value.createBy = createUser.value;

      postRequest.value.updateBy = userName;
      postRequest.value.id = id;
      postRequest.value.title = "Post Status from ${userName}";
      postRequest.value.category = selectedCategory.value!.toCategory();
      postRequest.value.status = selectedStatus.value;
      postRequest.value.description = postDescriptionController.value.text;
      postRequest.value.totalView = 0;


      var response = await postRepository.createNewPost(postRequest.value);
      print(filenameUploaded);
      if(response.code == "SUC-000"){
        showCustomToast(message: response.message!);
        Get.offAllNamed(RouteName.postManagePath);
      }else{
        showCustomToast(message: response.message!);
      }

      print(response);

    } finally {
      onCreateLoading(false);
    }
  }

  Future uploadImage(File imageFile) async {
    try {
      var response = await _postRepository.uploadImage(imageFile);
      print(response.data['data']);
      filenameUploaded.value = response.data['data'];
      print(response.code);
      if(response.code == "200"){
        print("Print file ${filenameUploaded}");
        // await onCreatePost();
        // Get.offAllNamed(RouteName.postManagePath);
      }else{
        showCustomToast(message: response.message.toString());
      }
      // Handle success
      print("Image uploaded successfully1: ${response.data.data}");
    } catch (e) {
      // Handle errors
      print("Image upload failed: $e");
    }

  }
}
