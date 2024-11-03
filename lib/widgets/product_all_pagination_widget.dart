import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/modules/home/controller/product_controller.dart';
import 'package:product_flutter_app/modules/home/widget/home_product_all_widget.dart';

class ProductAllPaginationWidget extends StatefulWidget {
  const ProductAllPaginationWidget({super.key});

  @override
  State<ProductAllPaginationWidget> createState() => _ProductAllPaginationWidgetState();
}

class _ProductAllPaginationWidgetState extends State<ProductAllPaginationWidget> {
  ProductController productController = Get.put(ProductController());
  HomeController homeController = Get.put(HomeController());
  var page = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pagination Controls
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
            bottom: 16,
            top: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print("previous");
                  setState(() {
                    productController.productPaginationPrevious(
                        productController.limit);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Icon(Icons.skip_previous),
                ),
              ),

              // Scrollable Pagination Numbers
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 38, // Fixed height for pagination
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            int pageNumber = index + 1;

                            return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  productController.page.value =
                                      (pageNumber - 1) * productController.limit;
                                  productController.fetchAllProducts(
                                      (pageNumber - 1) * productController.limit);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  color: productController.page == (pageNumber - 1) *
                                      productController.limit
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Text(
                                  "$pageNumber",
                                  style: TextStyle(
                                    color: productController.page ==
                                        (pageNumber - 1) *
                                            productController.limit
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 0,
                            );
                          },
                          itemCount: homeController.totalPage, // Total number of pages
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  print("next");
                  setState(() {
                    productController.productPaginationNext(
                        productController.limit);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Icon(Icons.skip_next),
                ),
              ),
            ],
          ),
        ),

        // Scrollable HomeProductAllWidget
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              productController.fetchAllProducts(page.value);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeProductAllWidget()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
