import 'package:get/get.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/repository/product_repository.dart';

class ProductViewModel extends GetxController {
  List<Product> productList = <Product>[].obs;
  var loading = true.obs;
  var loadingMore = true.obs;
  var currentPage = 0.obs;
  final limit = 10;
  final ProductRepository productRepository = ProductRepository();

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }

  fetchAllProducts() async {
    productList = [];
    try {
      loading(true);
      // currentPage.value = 0;
      var response =
          await productRepository.getAllProducts(limit, currentPage.value);
      productList.addAll(response.products!);
    } catch (e) {
      print(e.toString());
    } finally {
      loading(false);
    }
  }

  fetchMoreAllProducts() async {
    print("FETCHING MORE");
    try {
      loadingMore(true);
      currentPage += limit;
      // currentPage.value = 0;
      var response =
          await productRepository.getAllProducts(limit, currentPage.value);
      productList.addAll(response.products!);
    } catch (e) {
      print(e.toString());
    } finally {
      loadingMore(false);
    }
  }
}
