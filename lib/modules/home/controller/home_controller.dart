import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_flutter_app/models/category/category.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/modules/auth/login_response.dart';
import 'package:product_flutter_app/repository/auth_repository.dart';
import 'package:product_flutter_app/repository/category_repository.dart';
import 'package:product_flutter_app/repository/product_repository.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/toastMessage.dart';

class HomeController extends GetxController {
  var loading = true.obs;
  var loadingProduct = true.obs;
  var selectedCategory = 0.obs;
  var addToCard = 0.obs;
  final limit = 10;
  var currentPage = 0.obs;
  var isGrid = true.obs;
  int totalPage = 0;
  List<Category> categories = <Category>[].obs;
  List<Product> products = <Product>[].obs;
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProductRepository productRepository = ProductRepository();
  final AuthRepository authRepository = AuthRepository();
  final storage = GetStorage();
  var userLogin = LoginResponse().obs;


  @override
  void onInit() {
    checkUserLoggedIn();
    fetchAllCategory();
    super.onInit();
  }

  Future fetchAllCategory() async {
    try {
      categories = [];
      loading(true);
      var list = await categoryRepository.getAllCategory();
      var all = Category(
        slug: "all",
        name: "All"
      );
      categories.add(all);
      categories.addAll(list);
      fetchAllProducts();
    } catch (e) {
      Get.snackbar("ERROR", e.toString());
    } finally {
      loading(false);
    }
  }

  Future selectCategoryChange(int index) async {
    selectedCategory.value = index;
    if(index == 0){
      fetchAllProducts();
    }else {
      fetchAllProductsByCategorySlug(categories[index].slug ?? "");
    }
  }

  Future productPaginationNext(int pagination) async{
    // currentPage.value = pagination;
    fetchAllProductsByCategorySlugPagination(pagination);
  }

  Future fetchAllProducts() async {
    try {
      products = [];
      loadingProduct(true);
      var responseProduct = await productRepository.getAllProducts(limit, currentPage.value);
      products.addAll(responseProduct.products!);
      totalPage = (responseProduct.total!/limit).ceil();
      // showCustomToast(message: "Successfully retrieve products and page: $totalPage");
    } catch (e) {
      // Get.snackbar("ERROR", e.toString());
      showCustomToast(message: e.toString());
    } finally {
      loadingProduct(false);
    }
  }

  Future fetchAllProductsByCategorySlug(String slug) async {
    try {
      products = [];
      loadingProduct(true);
      var responseProduct =
          await productRepository.getAllProductsByCategorySlug(limit, currentPage.value, slug);
      products.addAll(responseProduct.products!);
      showCustomToast(message: "Successfully retrieve products");
    } catch (e) {
      // Get.snackbar("ERROR", e.toString());
      showCustomToast(message: e.toString());
    } finally {
      loadingProduct(false);
    }
  }

  Future fetchAllProductsByCategorySlugPagination(int currentPage) async {
    try {
      products = [];
      loadingProduct(true);
      var responseProduct =
          await productRepository.getAllProductsByPagination(limit, currentPage);
      products.addAll(responseProduct.products!);
      showCustomToast(message: "Successfully retrieve ");
    } catch (e) {
      // Get.snackbar("ERROR", e.toString());
      showCustomToast(message: e.toString());
    } finally {
      loadingProduct(false);
    }
  }

  onSelectChangeGrid(bool select){
    if(select == true){
      isGrid.value = true;
      print("grid");
    }else{
      isGrid.value = false;
      print("list");

    }
  }

  getUser() async{
    _fetchCachedImagePath();
    userLogin.value = await authRepository.getUserLocal();

  }

  Future<String?> _fetchCachedImagePath() async {
    print("fetch image from homescreen");
    return await authRepository.getCachedImagePath();
  }
  
  checkUserLoggedIn() async{
    if(storage.read("USER_KEY")==null){
      print("USER NULL"+storage.read("USER_KEY").toString());
    }else{
      print("USER NOT NULL"+storage.read("USER_KEY").toString());

    }
  }

}