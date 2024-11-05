class ApiUrl{
  static const String baseUrl = "https://dummyjson.com";
  static const String getAllCategoriesUrl = "$baseUrl/products/categories";

  static const String getAllProductsUrl = "$baseUrl/products";
  static const String getAllProductsByCategoryUrl = "$baseUrl/products/category";
  static const String loginPath = "$baseUrl/auth/login";

  static const String baseUrlPostApp = "http://194.233.91.140:20099";
  static const String postAppLoginPath = "$baseUrlPostApp/api/oauth/token";
  static const String postAppRefreshTokenPath = "$baseUrlPostApp/api/oauth/refresh";
  static const String postAppRegisterPath = "$baseUrlPostApp/api/oauth/register";
  static const String postAppCategoryPath = "$baseUrlPostApp/api/app/category/list";
  static const String postAppCreateCategoryPath = "$baseUrlPostApp/api/app/category/create";
  static const String postAppGetCategoryByIdPath = "$baseUrlPostApp/api/app/category/";
  static const String postGetAllPath = "$baseUrlPostApp/api/app/post/list";
  static const String postCreatePath = "$baseUrlPostApp/api/app/post/create";
  static const String postGetByIdPath = "$baseUrlPostApp/api/app/post/";
  static const String postGetImagePath = "$baseUrlPostApp/api/public/view/image?filename=";
  static const String postUploadImagePath = "$baseUrlPostApp/app/public/v1/image/upload";

}