import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/modules/home/controller/product_controller.dart';
import 'package:product_flutter_app/routes/app_routes.dart';
import 'package:product_flutter_app/toastAndLoader/home_product_loading_shimmer.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_card.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_loading_screen.dart';

class HomeProductAllWidget extends StatefulWidget {
  const HomeProductAllWidget({super.key});

  @override
  State<HomeProductAllWidget> createState() => _HomeProductAllWidgetState();
}

class _HomeProductAllWidgetState extends State<HomeProductAllWidget> {
  // HomeController homeController = Get.put(HomeController());
  ProductController productController = Get.put(ProductController());
  var addToCart = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.loadingProduct.value) {
        return HomeProductLoadingShimmer();
        //   Center(
        //   child: CircularProgressIndicator(
        //     color: Colors.black12,
        //   ),
        // );
      }
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 16,
        ),
        child: GridView.builder(
            itemCount: productController.products.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              var products = productController.products[index];
              return Container(
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            color: Colors.red,
                          ),
                          child: Text(
                            "- ${products.discountPercentage.toString()} %",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 2),
                        ),
                        Container(
                          child: Icon(
                            Icons.favorite_border,
                            size: 20,
                          ),
                          padding: EdgeInsets.only(right: 10),
                        )
                      ],
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("${RouteName.productDetailScreen}",
                              arguments: products.id);
                        },
                        child: Image.network(
                          products.thumbnail ?? "",
                          fit: BoxFit.cover,
                          height: 120,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        products.title ?? "",
                        style: TextStyle(fontSize: 12),
                        maxLines: 1, // Limits to 1 line
                        overflow: TextOverflow
                            .ellipsis, // Shows "..." if the text overflows
                        softWrap: false, // Prevents wrapping to a new line
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$ ${products.price}",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Views: ${products.reviews!.length}",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Right spacing (optional)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (addToCart > 0) {
                                  addToCart--;
                                }
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                addToCart.toString(),
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                addToCart++;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      );
    });
  }
}
