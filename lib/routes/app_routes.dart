import 'package:get/get.dart';
import 'package:product_flutter_app/modules/auth/view/login_screen.dart';
import 'package:product_flutter_app/modules/home/view/home_screen.dart';
import 'package:product_flutter_app/modules/product/view/product_view.dart';
import 'package:product_flutter_app/modules/product/product_see_all_screen.dart';
import 'package:product_flutter_app/modules/product/view/product_detail_view.dart';
import 'package:product_flutter_app/post/modules/auth/login/view/post_login_screen.dart';
import 'package:product_flutter_app/post/modules/auth/login/view/post_register_screen.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_form_widget_view.dart';
import 'package:product_flutter_app/post/modules/category/view/post_category_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_form_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_menu_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_profile_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_search_view.dart';
import 'package:product_flutter_app/post/modules/post/view/post_view.dart';
import 'package:product_flutter_app/post/modules/root/view/root_view.dart';
import 'package:product_flutter_app/post/modules/splash/view/splash_view.dart';
import 'package:product_flutter_app/post/modules/root/view/main_wrapper.dart';
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
  static const String postAppRegister = "/post/register";
  static const String postAppFormCreatePath = "/post/manage/create";
  static const String postMainWrapper = "/post/main";
  static const String postProfile = "/post/profile";
  static const String postSearch = "/post/search";
  static const String postMenu = "/post/menu";
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
            transition: Transition.native),
        GetPage(
            name: RouteName.postRoot,
            page: () => RootView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postLogin,
            page: () => PostLoginScreen(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postSplash,
            page: () => SplashView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postManageCategory,
            page: () => PostCategoryView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postManageCreateCategoryPath,
            page: () => PostCategoryFormWidgetView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postManagePath,
            page: () => PostView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postAppRegister,
            page: () => PostRegisterScreen(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postMainWrapper,
            page: () => MainWrapper(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postAppFormCreatePath,
            page: () => PostFormView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postProfile,
            page: () => PostProfileView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postSearch,
            page: () => PostSearchView(),
            transition: Transition.native),
        GetPage(
            name: RouteName.postMenu,
            page: () => PostMenuView(),
            transition: Transition.native)
      ];
}
