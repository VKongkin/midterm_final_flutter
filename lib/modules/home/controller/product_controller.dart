
import 'package:get/get.dart';
import 'package:product_flutter_app/models/category/category.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/repository/category_repository.dart';
import 'package:product_flutter_app/repository/product_repository.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class ProductController extends GetxController{
  var loading = true.obs;
  var loadingProduct = true.obs;
  var selectedCategory = 0.obs;
  var addToCard = 0.obs;
  final limit = 10;
  var isPagination = true.obs;
  var page = 0.obs;
  int allProducts = 0;
  int totalPagination = 0;

  List<Category> categories = <Category>[].obs;
  List<Product> products = <Product>[].obs;
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProductRepository productRepository = ProductRepository();


  @override
  void onInit() {
    fetchAllProducts(page.value);
    showCustomToast(message: "All product are : "+allProducts.toString()+"And pagination : $totalPagination");
    page.value = allProducts;
    super.onInit();
  }

  Future fetchAllProducts(page) async {
    try {
      products = [];

      loadingProduct(true);
      var responseProduct = await productRepository.getAllProducts(limit, page);
      products.addAll(responseProduct.products!);
      allProducts = await responseProduct.total!;
      totalPagination = (allProducts / limit).ceil();
      showCustomToast(message: "Successfully retrieve products");
    } catch (e) {
      // Get.snackbar("ERROR", e.toString());
      showCustomToast(message: e.toString());
    } finally {
      loadingProduct(false);
      showCustomToast(message: "All product are : "+allProducts.toString()+"And pagination : $totalPagination");
    }
  }
  Future fetchAllProductsNoLimit() async {
    try {
      // allProducts = [];

      // loadingProduct(true);
      var responseProduct = await productRepository.getAllProductsNoLimit();
      // allProducts.value = responseProduct;
      print(responseProduct);
      showCustomToast(message: "Successfully retrieve all products ${responseProduct.toString()}");

    } catch (e) {
      // Get.snackbar("ERROR", e.toString());
      showCustomToast(message: e.toString());
    }
  }

  Future productPaginationNext(int pagination) async {
    // currentPage.value = pagination;
    // fetchAllProductsByCategorySlugPagination(pagination);
     totalPagination = (allProducts / limit).ceil();

    if (page.value < allProducts) {

      page.value += pagination;
      pagination = page.value;
      fetchAllProducts(pagination);
      print("page: $page");
      print(products.length.toString());
      showCustomToast(message: "All product are : "+allProducts.toString()+" and total page: $totalPagination");
    }
  }
  Future productPaginationPrevious(int pagination) async{
    // currentPage.value = pagination;
    // fetchAllProductsByCategorySlugPagination(pagination);


    if(page.value >0){
      page.value -= pagination;
      pagination = page.value;
      fetchAllProducts(pagination);
      print(page);
      print(products.length.toString());
      showCustomToast(message: "All product: ${allProducts.toString()}");
    }
  }

  onChangePagination(bool x) async{
    if(x == true){
      isPagination.value = true;
    }else{
      isPagination.value = false;
    }
  }
}
