import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/home_product_loading_shimmer.dart';
import 'package:product_flutter_app/toastAndLoader/product_card_list_loading_shimmer.dart';
import 'package:product_flutter_app/widgets/product_card_grid_widget.dart';

class HomeProductWidget extends StatefulWidget {
  const HomeProductWidget({super.key});

  @override
  State<HomeProductWidget> createState() => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  HomeController homeController = Get.put(HomeController());
  var addToCart = 0;
  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
      if (homeController.loadingProduct.value) {
        return homeController.isGrid.value == true ? HomeProductLoadingShimmer() : ProductCardListLoadingShimmer();
      }
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 16,
        ),
        child: GridView.builder(
            itemCount: homeController.products.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              var products = homeController.products[index];
              return ProductCardGridWidget(products: products, onTapImage: (){

                Get.toNamed("${RouteName.productDetailScreen}", arguments: products.id);
              }, );
            }),
      );
    });
  }
}
