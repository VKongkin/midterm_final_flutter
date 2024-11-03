import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/modules/home/controller/home_controller.dart';
import 'package:product_flutter_app/toastAndLoader/home_category_loading_shimmer.dart';
import 'package:product_flutter_app/toastAndLoader/home_product_loading_shimmer.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_card.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.loading.value) {
        return HomeCategoryLoadingShimmer();
      }
      return SizedBox(
        height: 50,
        child:
        ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var category = homeController.categories[index];
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    homeController.selectCategoryChange(index);
                  });
                },
                child: Container(
                  // color: Colors.cyanAccent,
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: homeController.selectedCategory == index ? Colors.lightBlue : Colors.cyanAccent),
                  child: Text(category.name ?? ""),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: homeController.categories.length),
      );
    });
  }
}
