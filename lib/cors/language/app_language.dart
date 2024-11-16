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
    }
  };

}