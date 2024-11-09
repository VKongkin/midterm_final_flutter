import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/postmodel/base_post_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_request.dart';
import 'package:product_flutter_app/models/postmodel/post_base_response.dart';
import 'package:product_flutter_app/models/postmodel/post_category.dart';
import 'package:product_flutter_app/models/postmodel/response/post_response.dart';

class PostRepository {
  final _api = NetworkApiService();


  Future<PostBaseResponse> getAllPostCategories(BasePostRequest req) async{
    var response = await _api.postApi(ApiUrl.postAppCategoryPath, req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> createPostCategories(PostCategory req) async{
    var response = await _api.postApi(ApiUrl.postAppCreateCategoryPath, req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> getCategoryById(BasePostRequest req) async{
    var response = await _api.postApi(ApiUrl.postAppGetCategoryByIdPath+req.id.toString(), req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> getAllPosts(PostBaseRequest req) async{
    var response = await _api.postApi(ApiUrl.postGetAllPath, req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> createPost(PostResponse res) async{
    var response = await _api.postApi(ApiUrl.postCreatePath, res.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> getPostById(BasePostRequest req) async{
    var response = await _api.postApi(ApiUrl.postGetByIdPath+req.id.toString(), req.toJson());
    return PostBaseResponse.fromJson(response);
  }

}