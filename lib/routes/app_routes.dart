import 'package:get/get.dart';
import 'package:product_flutter_app/modules/auth/view/login_screen.dart';
import 'package:product_flutter_app/modules/home/view/home_screen.dart';
import 'package:product_flutter_app/modules/product/view/product_view.dart';
import 'package:product_flutter_app/modules/product/product_see_all_screen.dart';
import 'package:product_flutter_app/modules/product/view/product_detail_view.dart';
import 'package:product_flutter_app/post/modules/auth/login/view/post_login_screen.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_form_widget_view.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/view/root_view.dart';
import 'package:product_flutter_app/post/modules/splash/view/splash_view.dart';
import 'package:product_flutter_app/toastAndLoader/product_card_list_loading_shimmer.dart';
import 'package:product_flutter_app/toastAndLoader/shimmer_loading_screen.dart';

class RouteName {
  static const String homeScreen = "/";
  static const String productScreen = "/product";
  static const String loginScreen = "/login";
  static const String allProductsScreen = "/all-products";
  static const String shimmerLoading = "/shimmer";
  static const String productDetailScreen = "/product/details";
  static const String postRoot = "/post/root";
  static const String postLogin = "/post/login";
  static const String postSplash = "/post/splash";
  static const String postManageCategory = "/post/manage/category";
  static const String postManageCreateCategoryPath = "/post/manage/category/create";
  static const String postManagePath = "/post/manage/post";
}

class AppRoute {
  static appRoutes() => [
        GetPage(
            name: RouteName.homeScreen,
            page: () => HomeScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.productScreen,
            page: () => ProductScreen(),
            transition: Transition.noTransition),
        GetPage(
            name: RouteName.loginScreen,
            page: () => LoginScreen(),
            transition: Transition.fade),
        GetPage(
            name: RouteName.allProductsScreen,
            page: () => ProductSeeAllScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.shimmerLoading,
            page: () => ProductCardListLoadingShimmer(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.productDetailScreen,
            page: () => ProductDetailView(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postRoot,
            page: () => RootView(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postLogin,
            page: () => PostLoginScreen(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postSplash,
            page: () => SplashView(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postManageCategory,
            page: () => PostCategoryView(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postManageCreateCategoryPath,
            page: () => PostCategoryFormWidgetView(),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.postManagePath,
            page: () => PostView(),
            transition: Transition.leftToRightWithFade)
      ];
}
