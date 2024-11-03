import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/data/remote/network_api_service.dart';
import 'package:product_flutter_app/post/modules/category/view_model/post_category_form_widget_view_model.dart';
import 'package:product_flutter_app/post/widgets/custom_button_widget.dart';
import 'package:product_flutter_app/post/widgets/custom_input_widget.dart';

class PostCategoryFormWidgetView extends StatelessWidget {
  var viewModel = Get.put(PostCategoryFormViewModel());
  PostCategoryFormWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "${viewModel.categoryRequest.value.id == 0 ? "Create" : "Update"} Category".tr,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputWidget(
                controller: viewModel.categoryNameController.value,
                hintText: "Category Name",
                labelText: "Category Name",
              ),
              CustomButtonWidget(
                onLoading: viewModel.onCreateLoading.value,
                onTab: () {
                  viewModel.onCreateCategory();
                },
                title: viewModel.categoryRequest.value.id == 0? "Create" : "Update",
                borderRadius: 10,
              )
            ],
          )


        ));
  }
}
