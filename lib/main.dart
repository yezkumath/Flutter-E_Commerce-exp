import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/controllers/popular_product_controller.dart';
import 'package:e_commer/controllers/recommanded_product_controller.dart';
import 'package:e_commer/pages/cart/cart_page.dart';
import 'package:e_commer/pages/food/popular_food_detail.dart';
import 'package:e_commer/pages/food/recomanded_food_detail.dart';
import 'package:e_commer/pages/home/food_page_body.dart';
import 'package:e_commer/pages/home/main_food_page.dart';
import 'package:e_commer/pages/splash/spalash_page.dart';
import 'package:e_commer/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductConroller>(builder: (_){
      return GetBuilder<RecommandedProductConroller>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false, // for disable debug logo
          title: 'Flutter Demo',
          //home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
    ); 
      });
    });
    
  }
}