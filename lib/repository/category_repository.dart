import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/category/category.dart';

class CategoryRepository{
  final NetworkApiService apiService = NetworkApiService();

  Future<List<Category>> getAllCategory() async {
    List<Category> res = [];
    var response = await apiService.getApi(ApiUrl.getAllCategoriesUrl);
    response.forEach((data){
      res.add(Category.fromJson(data));
    });

    return res;
}


}