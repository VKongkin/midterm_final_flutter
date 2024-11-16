import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_response.dart';
import 'package:product_flutter_app/models/postmodel/response/post_response.dart';
import 'package:product_flutter_app/post/modules/post/post_request.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class PostViewModel extends GetxController {
  var storage = GetStorage();
  // var searchController = TextEditingController()
  var postList = <PostResponse>[].obs;
  var postSearchList = <PostResponse>[].obs;
  var postProfileList = <PostResponse>[].obs;
  var loading = true.obs;
  var currentPage = 0.obs;
  var firstname = "".obs;
  var lastname = "".obs;
  var imagepath = "".obs;
  var postRequest = PostRequest().obs;
  var requestLoadingPostStatus = Status.loading.obs;
  void setRequestLoadingPostStatus(Status value) {
    requestLoadingPostStatus.value = value;
  }

  final _postRepository = PostRepository();

  @override
  void onInit() {

    loadingData();
    print(imagepath);
    super.onInit();
  }

  loadingData() {
    setRequestLoadingPostStatus(Status.loading);
    try {
      getAllPost();
      _getAllPostByUserId();
    } finally {
      setRequestLoadingPostStatus(Status.completed);
    }
  }

  loadingDataMore() {
    setRequestLoadingPostStatus(Status.loading);
    try {
      getAllPostMore(1);
    } finally {
      setRequestLoadingPostStatus(Status.completed);
    }
  }


  loadingDataMoreSearch(String name) {
    setRequestLoadingPostStatus(Status.loading);
    try {
      getAllPostMoreSearchPost(1, name);
    } finally {
      setRequestLoadingPostStatus(Status.completed);
    }
  }

  loadingDataMoreProfilePost() {
    setRequestLoadingPostStatus(Status.loading);
    try {
      getAllPostMoreProfilePost(1);

    } finally {
      setRequestLoadingPostStatus(Status.completed);
    }
  }

  getAllPost() async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];
    firstname.value = data['user']['firstName'];
    lastname.value = data['user']['lastName'];
    imagepath.value = data['user']['profile'];
    print("PRINT PROFILE ${firstname} ${lastname} ${imagepath}");
    var request = PostBaseRequest();
    postList.value = [];
    try {
      loading(true);
      request = PostBaseRequest(status: "ACT");
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      loading(false);
    }
  }

  getAllSearchPost(String name) async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];
    firstname.value = data['user']['firstName'];
    lastname.value = data['user']['lastName'];
    imagepath.value = data['user']['profile'];
    print("PRINT PROFILE ${firstname} ${lastname} ${imagepath}");
    var request = PostBaseRequest();
    postSearchList.value = [];
    try {
      loading(true);
      request = PostBaseRequest(name: name,status: "ACT");
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postSearchList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      loading(false);
    }
  }

  getAllProfilePost() async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];
    // firstname.value = data['user']['firstName'];
    // lastname.value = data['user']['lastName'];
    // imagepath.value = data['user']['profile'];
    // print("PRINT PROFILE ${firstname} ${lastname} ${imagepath}");
    var request = PostBaseRequest(userId: userId,);
    postProfileList.value = [];
    try {
      loading(true);
      request = PostBaseRequest(userId: userId,status: "ACT");
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postProfileList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      loading(false);
    }
  }

  getAllPostMore(int page) async {
    var request = PostBaseRequest();
    var totalPage = postList.value.length;
    var limitPage = request.limit;
    var current = 0;
    // Ensure limitPage is not zero to avoid division by zero error
    if (limitPage != null && limitPage > 0) {
      current = (totalPage / limitPage)
          .ceil(); // .ceil() rounds up to the nearest integer
    }
    // current = (totalPage/limitPage!) as dynamic;

    print(
        "LOADING DATA MORE ${totalPage} AND CURRENT ${current} LIMIT ${limitPage}");
    current += page;

    print(request.status);
    try {
      // requestLoadingPostStatus(Status.loading);
      loading(true);
      request = PostBaseRequest(status: "ACT", page: current);
      print(request.status);
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      // requestLoadingPostStatus(Status.completed);
      loading(false);
      // Pause on cannot make loading data more
    }
  }

  getAllPostMoreProfilePost(int page) async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];
    var request = PostBaseRequest(userId: userId, status: "ACT");
    var totalPage = postProfileList.value.length;
    var limitPage = request.limit;
    var current = 0;
    // Ensure limitPage is not zero to avoid division by zero error
    if (limitPage != null && limitPage > 0) {
      current = (totalPage / limitPage)
          .ceil(); // .ceil() rounds up to the nearest integer
    }
    // current = (totalPage/limitPage!) as dynamic;

    print(
        "LOADING DATA MORE ${totalPage} AND CURRENT ${current} LIMIT ${limitPage}");
    current += page;

    print(request.status);
    try {
      // requestLoadingPostStatus(Status.loading);
      loading(true);
      request = PostBaseRequest(userId: userId, status: "ACT", page: current);
      print(request.status);
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postProfileList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      // requestLoadingPostStatus(Status.completed);
      loading(false);
      // Pause on cannot make loading data more
    }
  }

  getAllPostMoreSearchPost(int page, String name) async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];
    var request = PostBaseRequest(name: name, status: "ACT");
    var totalPage = postSearchList.value.length;
    var limitPage = request.limit;
    var current = 0;
    // Ensure limitPage is not zero to avoid division by zero error
    if (limitPage != null && limitPage > 0) {
      current = (totalPage / limitPage)
          .ceil(); // .ceil() rounds up to the nearest integer
    }
    // current = (totalPage/limitPage!) as dynamic;

    print(
        "LOADING DATA MORE ${totalPage} AND CURRENT ${current} LIMIT ${limitPage}");
    current += page;

    print(request.status);
    try {
      // requestLoadingPostStatus(Status.loading);
      loading(true);
      request = PostBaseRequest(name: name, status: "ACT", page: current);
      print(request.status);
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postSearchList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      // requestLoadingPostStatus(Status.completed);
      loading(false);
      // Pause on cannot make loading data more
    }
  }

  _getAllPostByUserId() async {
    var data = storage.read("USER_KEY");
    var userId = data['user']['id'];

    // print(data['user']['id']);
    var request = PostBaseRequest(userId: userId, status: "ACT");
    var response = await _postRepository.getAllPosts(request);
    if (response.data != null) {
      response.data.forEach((data) {
        postProfileList.add(PostResponse.fromJson(data));
      });
    }
  }

  onDeletePost(int id) async {
    print("ON DELETE");

    // Step 1: Fetch the post details
    var request = BasePostRequest(id: id, status: "ACT");
    var response = await _postRepository.getPostById(request);

    print("RESPONSE ${response.data}");
    if (response.code == "SUC-000") {
      // Step 2: Use PostResponse.fromJson to map response data
      var postResponse = PostResponse.fromJson(response.data);

      // Step 3: Update the status to "DEL"
      postResponse.status = "DEL";

      // Step 4: Call deletePost with the updated PostResponse
      var delResponse = await _postRepository.deletePost(postResponse);
      if(delResponse.code ==  "SUC-000"){
        loadingData();
      }else{
        showCustomToast(message: delResponse.message!);
      }

      print("DELETE RESPONSE: ${delResponse}");
    } else {
      print("Failed to fetch post details for deletion.");
    }
  }

  void onUpdate(String id) {
    print("ON UPDATE");
    Get.toNamed(RouteName.postAppFormCreatePath, parameters: {
      "id":"${id}"
    })?.then((onValue){
      if(onValue == true){
        print("ON VALUE TRUE");
        postList.value = [];
        showCustomToast(message: "Category Updated Successfully");
        getAllPost();
      }
    });
  }

  onSearch(String? name) async {
    if (name == null || name.trim().isEmpty) {
      postSearchList.value = [];
      return; // Exit if search query is empty
    }
    loading(true); // Indicate loading state
    postSearchList.value =[]; // Clear previous search results
    try {
      var request = PostBaseRequest(status: "ACT", name: name);
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postSearchList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      loading(false); // Reset loading state
    }
  }



}
