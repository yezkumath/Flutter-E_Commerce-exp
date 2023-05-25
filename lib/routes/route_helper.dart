import 'package:e_commer/pages/cart/cart_page.dart';
import 'package:e_commer/pages/food/popular_food_detail.dart';
import 'package:e_commer/pages/food/recomanded_food_detail.dart';
import 'package:e_commer/pages/home/home_page.dart';
import 'package:e_commer/pages/home/main_food_page.dart';
import 'package:e_commer/pages/splash/spalash_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial="/"; //homepage
  static const String popularFood="/popular-food";
  static const String recommandedFood="/rocommanded-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage()=> '$splashPage';
  static String getInitial()=> '$initial';
  static String getPopularFood(int pageId, String page)=> '$popularFood?pageId=$pageId&page=$page';
  static String getRecommandedFood(int pageId, String page)=> '$recommandedFood?pageId=$pageId&page=$page';
  static String getCartPage()=> '$cartPage';

  static List<GetPage> routes = [

    GetPage(name: splashPage, page: ()=>SplashScreen()),

    GetPage(name: initial, page: ()=>HomePage()),


    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      print("Popular food get called");
      return PopularFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn
    ),


     GetPage(name: recommandedFood, page: (){
       var pageId = Get.parameters['pageId'];
       var page = Get.parameters['page'];
      print("Recommanded food get called");
      return RecomandedFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn
    ),


    GetPage(name: cartPage, page: (){
      print("Cart Page get called");
      return CartPage();
    },
      transition: Transition.fadeIn
    ),

  ];
}