import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/controllers/popular_product_controller.dart';
import 'package:e_commer/controllers/recommanded_product_controller.dart';
import 'package:e_commer/data/api/api_client.dart';
import 'package:e_commer/data/repository/cart_repo.dart';
import 'package:e_commer/data/repository/popular_product_repo.dart';
import 'package:e_commer/data/repository/recommanded_product_repo.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async{

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // api client
  Get.lazyPut(()=> ApiClient(appBaseUrl:AppConstrants.BASE_URL));
  
  //repos
   Get.lazyPut(()=> PopularProductRepo(apiClient: Get.find()));
   Get.lazyPut(()=> RecommandedProductRepo(apiClient: Get.find()));
   Get.lazyPut(()=> CartRepo(sharedPreferences:Get.find()));

   //controller
    Get.lazyPut(()=> PopularProductConroller(popularProductRepo: Get.find()));
    Get.lazyPut(()=> RecommandedProductConroller(recommandedProductRepo: Get.find()));
    Get.lazyPut(()=> CartController(cartRepo: Get.find()));
}