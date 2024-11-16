import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
    updateIndex(index);
  }

  void navigateToProfile() {
    pageController.jumpToPage(6); // Assuming PostProfileView is at index 6
    currentIndex.value = 6; // Update the index to highlight the corresponding tab
  }

}
