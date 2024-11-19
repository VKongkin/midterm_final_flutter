import 'package:get/get.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/data/status.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_category.dart';
import 'package:product_flutter_app/repository/post/post_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class PostCategoryViewModel extends GetxController{
  final _repository = PostRepository();
  var categoryList = <PostCategory>[].obs;
  var loadingRequestAllCategoryStatus = Status.loading.obs;

  void setLoadingRequestAllCategoryStatus(Status value) => loadingRequestAllCategoryStatus.value = value;
  var baseRequest = BasePostRequest().obs;

  @override
  void onInit() {
    loadingCategoryData();
    super.onInit();
  }

  loadingCategoryData() async{
    setLoadingRequestAllCategoryStatus(Status.loading);
    await _fetchAllCategories();
    setLoadingRequestAllCategoryStatus(Status.completed);

  }
  _fetchAllCategories() async{
    print("fetching all categories");
    try {
      var response = await _repository.getAllPostCategories(baseRequest.value);
      response.data.forEach((data) {
        categoryList.add(PostCategory.fromJson(data));
      });
    }
    // catch(e){
    //   setLoadingRequestAllCategoryStatus(Status.error);
    //   showCustomToast(message: e.toString());
    // }
    finally{
      setLoadingRequestAllCategoryStatus(Status.completed);
    }
  }

  void onCreate() {
    print("ON CREATE");
    Get.toNamed(RouteName.postManageCreateCategoryPath, parameters: {
      "id":"0"
    })?.then((onValue){
      if(onValue == true){
        print("ON VALUE TRUE");
        categoryList.value = [];
        showCustomToast(message: "Category Created Successfully");
        _fetchAllCategories();
      }
    });
  }

  void onUpdate(String id) {
    print("ON UPDATE");
    Get.toNamed(RouteName.postManageCreateCategoryPath, parameters: {
      "id":"${id}"
    })?.then((onValue){
      if(onValue == true){
        print("ON VALUE TRUE");
        categoryList.value = [];
        showCustomToast(message: "Category Updated Successfully");
        _fetchAllCategories();
      }
    });
  }
}
