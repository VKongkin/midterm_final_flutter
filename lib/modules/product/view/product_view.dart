import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/modules/home/controller/product_controller.dart';
import 'package:product_flutter_app/modules/home/widget/home_product_all_widget.dart';
import 'package:product_flutter_app/modules/product/product_see_all_screen.dart';
import 'package:product_flutter_app/widgets/product_all_pagination_widget.dart';
import 'package:product_flutter_app/widgets/product_all_scroll_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // HomeController homeController = Get.put(HomeController());
  ProductController productController = Get.put(ProductController());
  HomeController homeController = Get.put(HomeController());
  var page = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.productList.tr,
          style: TextStyle(
              color: Colors.white
          ),),
        backgroundColor: Colors.blue,
        actions: [

          Container(
            height: 30,
            margin: EdgeInsets.only(right: 10), // Add some right margin for spacing
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if(productController.isPagination == true){
                    productController.onChangePagination(false);
                  }else{
                    productController.onChangePagination(true);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded edges
                ),
              ),
              child: Text(
                productController.isPagination == true ? "Scroll" : "Pagination",
                style: TextStyle(color: Colors.blue), // Button text style
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFF8FB9FF),
      body: productController.isPagination == true ? ProductAllPaginationWidget() : ProductAllScrollWidget()

    );
  }
}
