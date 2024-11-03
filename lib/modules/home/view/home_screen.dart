import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/modules/home/widget/home_app_bar_widget.dart';
import 'package:product_flutter_app/modules/home/widget/home_category_widget.dart';
import 'package:product_flutter_app/modules/home/widget/home_product_list_widget.dart';
import 'package:product_flutter_app/modules/home/widget/home_product_widget.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Obx(() {
          return SafeArea(
            top: true,
            child: Column(
              children: [
                // Keep the HomeAppBarWidget at the top, outside of the scrollable area
                HomeAppBarWidget(),

                // Expanded is used to make the remaining content scrollable
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      homeController.fetchAllCategory();
                    },
                    child: Container(
                      color: Color(0xFF8FB9FF),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            HomeCategoryWidget(),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16,
                                bottom: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(Constants.spacialProduct.tr),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Icon(
                                          Icons.list_alt_rounded,
                                          color: homeController.isGrid.value
                                              ? Colors.grey
                                              : Colors.blue,
                                        ),
                                        onTap: () {
                                          homeController
                                              .onSelectChangeGrid(false);
                                        },
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.grid_view_rounded,
                                          color: homeController.isGrid.value
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onTap: () {
                                          homeController
                                              .onSelectChangeGrid(true);
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(RouteName.productScreen);
                                        },
                                        child: Text(
                                          Constants.seeAll.tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            homeController.isGrid.value
                                ? HomeProductWidget()
                                : HomeProductListWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
