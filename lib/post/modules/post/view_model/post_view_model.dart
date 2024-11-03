import 'package:get/get.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_request.dart';
import 'package:product_flutter_app/models/postmodel/response/post_response.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';

class PostViewModel extends GetxController{
  var postList = <PostResponse>[].obs;
  var requestLoadingPostStatus = Status.loading.obs;
  void setRequestLoadingPostStatus(Status value){
    requestLoadingPostStatus.value = value;
  }

  final _postRepository = PostRepository();

  @override
  void onInit() {
    loadingData();
    super.onInit();
  }

  loadingData(){
    setRequestLoadingPostStatus(Status.loading);
    try{
      _getAllPost();
    }finally{
      setRequestLoadingPostStatus(Status.completed);
    }
  }

  _getAllPost() async {
    var request = PostBaseRequest();
    var response = await _postRepository.getAllPosts(request);
    if(response.data !=null) {
      response.data.forEach((data) {
        postList.add(PostResponse.fromJson(data));
      });
    }
  }

}