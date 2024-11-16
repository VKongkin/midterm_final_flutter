import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/modules/product/view_model/product_view_model.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/product_card_list_loading_shimmer.dart';
import 'package:product_flutter_app/widgets/product_card_list_small_widget.dart';

class ProductAllScrollWidget extends StatefulWidget {

  ProductAllScrollWidget({super.key});

  @override
  State<ProductAllScrollWidget> createState() => _ProductAllScrollWidgetState();
}

class _ProductAllScrollWidgetState extends State<ProductAllScrollWidget> {
  final ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8FB9FF),
      body: Obx(() {
        if (productViewModel.loading.value) {
          return ProductCardListLoadingShimmer(flex: 6,widthFactor: 1,);
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!productViewModel.loading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              setState(() {
                // productViewModel.fetchMoreAllProducts();
                print("Fetching more");
              });
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async{
              productViewModel.fetchAllProducts();
            },
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
                itemCount: productViewModel.productList.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return ProductCardListSmallWidget(
                      products: productViewModel.productList[index], onTapImage: (){

                    Get.toNamed("${RouteName.productDetailScreen}", arguments: productViewModel.productList[index].id);
                  },);
                }),
          ),
        );
      }),
    );
  }
}
