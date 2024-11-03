import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/product/view_model/product_detail_view_model.dart';
import 'package:product_flutter_app/toastAndLoader/home_product_loading_shimmer.dart';
import 'package:product_flutter_app/widgets/product_card_grid_widget.dart';
import 'package:product_flutter_app/widgets/product_card_list_widget.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ProductDetailViewModel productDetailViewModel =
      Get.put(ProductDetailViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor: Colors.blue,
          title: Text(
            Constants.productDetail.tr,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        body: Obx(() {
          if (productDetailViewModel.loading.value) {
            return HomeProductLoadingShimmer();
          }
          var product = productDetailViewModel.product.value;
          double finalPrice = product.price! -
              ((product.discountPercentage / 100) * product.price);
          return SingleChildScrollView(
            child: Column(
              children: [
                ProductCardListWidget(
                  products: product,
                ),
                Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.title.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "\$" + finalPrice.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "\$" + product.price.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                decoration: TextDecoration
                                    .lineThrough, // Adds a strikethrough
                                decorationColor:
                                    Colors.grey, // Color of the line
                                decorationThickness: 2, // Thickness of the line
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Divider(
                  color: Color(0xffc3d2e0),
                  thickness: 7,
                ),
                Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              width: 120,
                              child: Text(
                                "Brand",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                product.brand.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              width: 120,
                              child: Text(
                                "Warranty",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                product.warrantyInformation.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              width: 120,
                              child: Text(
                                "Delivery Term",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                product.shippingInformation.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Divider(
                  color: Color(0xffc3d2e0),
                  thickness: 7,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      color: Color(0xffc3d2e0),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  height: 40,
                  child: Center(
                      child: Text(
                    "Description",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    product.description ?? "",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
