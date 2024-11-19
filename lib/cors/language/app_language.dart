import 'package:get/get.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';

class AppLanguage extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    //English
    "en_US":{
      Constants.appName:"Online Shop App",
      Constants.productDetail:"Product Details",
      Constants.productList:"Product List",
      Constants.seeAll:"See All",
      Constants.spacialProduct:"Spacial Product",
      Constants.postAppName:"Post App",
      Constants.postAppCategoryManageName:"Category Management",
      Constants.postAppPostManageName:"Post Management",
      Constants.postAppSearchName:"Search Post",
      Constants.Home:"Home",
      Constants.Category:"Category",
      Constants.Profile:"User Profile",
      Constants.Menu:"Menu",
      Constants.UserManage:"User Management",
      Constants.CategoryManage:"Category Management",
      Constants.CreatePost:"Create Post",
      Constants.UpdatePost:"Update Post",
      Constants.CreateCategory:"Create Category",
      Constants.UpdateCategory:"Update Category",
      Constants.Create:"Create",
      Constants.Update:"Update",
      Constants.Search:"Search Post",
      Constants.logOut:"Log out",
      Constants.notFound:"No results found.",

    },


    //Khmer
    "km_KH":{
      Constants.appName:"ហាងអនឡាញ",
      Constants.productDetail:"ព័ត៌មានលម្អិតនៃផលិតផល",
      Constants.productList:"ផលិតផលទាំងអស់",
      Constants.seeAll:"មើលទាំងអស់",
      Constants.spacialProduct:"ផលិតផលពិសេសៗ",
      Constants.postAppName:"កម្មវិធីផុសដោយសេរី",
      Constants.postAppCategoryManageName:"ការគ្រប់គ្រងកាតិកូរី",
      Constants.postAppPostManageName:"គ្រប់គ្រង់ការផុស",
      Constants.postAppSearchName:"ស្វែងរកការផុស",
      Constants.Home:"ទំព័រដើម",
      Constants.Category:"កាតិកូរី",
      Constants.Profile:"ប្រវត្តិរូប",
      Constants.Menu:"មីនុយ",
      Constants.UserManage:"គ្រប់គ្រងអ្នកប្រើប្រាស់",
      Constants.CategoryManage:"គ្រប់គ្រងកាតិកូរី",
      Constants.CreatePost:"បង្កើតផុសថ្មី",
      Constants.UpdatePost:"ធ្វើបច្ចុប្បន្នភាពការផុស",
      Constants.CreateCategory:"បង្កើតកាតិកូរី",
      Constants.UpdateCategory:"ធ្វើបច្ចុប្បន្នភាពកាតិកូរី",
      Constants.Create:"បង្កើត",
      Constants.Update:"ធ្វើបច្ចប្បន្នភាព",
      Constants.Search:"ស្វែងរក",
      Constants.logOut:"ចាកចេញ",
      Constants.notFound:"រកមិនឃើញពត៌មាន",

    }
  };

}