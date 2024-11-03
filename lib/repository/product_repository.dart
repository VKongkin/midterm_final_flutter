import 'package:product_flutter_app/data/remote/api_url.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/models/product/product_response.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class ProductRepository{
  final NetworkApiService apiService = NetworkApiService();


  Future<ProductResponse> getAllProducts(int limit, int page) async {
    var response = await apiService.getApi(ApiUrl.getAllProductsUrl+"?limit=$limit&skip=$page");
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }
  Future<ProductResponse> getAllProductsNoLimit() async {
    var response = await apiService.getApi(ApiUrl.getAllProductsUrl+"?limit=0");
    ProductResponse productResponse = ProductResponse.fromJson(response.total);
    // print("All product response: $productResponse");
    showCustomToast(message: productResponse.toString());
    return productResponse;
  }
  Future<ProductResponse> getAllProductsByCategorySlug(int limit, int page, String slug) async {
    var response = await apiService.getApi(ApiUrl.getAllProductsByCategoryUrl+"/$slug?limit=$limit&page=$page");
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }

  Future<ProductResponse> getAllProductsByPagination(int limit, int page) async {
    var response = await apiService.getApi(ApiUrl.getAllProductsByCategoryUrl+"?limit=$limit&page=$page");
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }

  Future<Product> getProductById(int id) async{
    var response = await apiService.getApi(ApiUrl.getAllProductsUrl+"/$id");
    return Product.fromJson(response);
  }
}