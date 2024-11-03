import 'package:get/get.dart';
import 'package:product_flutter_app/models/product/products.dart';
import 'package:product_flutter_app/repository/product_repository.dart';

class ProductDetailViewModel extends GetxController{
  final ProductRepository productRepository = ProductRepository();
  var product = Product().obs;
  var loading = true.obs;


  @override
  void onInit() {
    fetchProductById();
    print("fetching data");
    super.onInit();
  }


  fetchProductById() async {
    try{
      print("loading");
      loading(true);

      product.value = await productRepository.getProductById(Get.arguments ?? 0);
    }finally{
      loading(false);
    }
  }
}