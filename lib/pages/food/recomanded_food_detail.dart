import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/controllers/recommanded_product_controller.dart';
import 'package:e_commer/pages/cart/cart_page.dart';
import 'package:e_commer/routes/route_helper.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:e_commer/widget/app_icon.dart';
import 'package:e_commer/widget/big_text.dart';
import 'package:e_commer/widget/expandable_text_widget.dart';
import 'package:e_commer/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:e_commer/utils/dimensions.dart';

class RecomandedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecomandedFoodDetail({ Key? key,
    required this.pageId,
    required this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommandedProductConroller>().RecommandedProductList[pageId];
    Get.find<RecommandedProductConroller>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                GestureDetector(
                  onTap: (){
                    if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.initial);
                    }
                },
                  child: AppIcon(icon: Icons.clear)
                ),
                GetBuilder<RecommandedProductConroller>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItem>=1)
                       Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.add_shopping_cart_outlined),
                        Get.find<RecommandedProductConroller>().totalItem>=1?
                          Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle, 
                              size: Dimensions.radius20, 
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),
                          ):
                          Container(),
                        Get.find<RecommandedProductConroller>().totalItem>=1?
                          Positioned(
                            right: 6,
                            top: 3,
                            child: BigText(
                              text:Get.find<RecommandedProductConroller>().totalItem.toString(),
                              size: 12,
                              color: Colors.white,
                            ),
                          ):
                          Container()
                      ],
                    ),
                  );
                })
              ]
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                child: Center(child: BigText(size: Dimensions.font26, text: product.name,)), // name product
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight:  Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                 AppConstrants.BASE_URL + AppConstrants.UPLOAD + product.img! , // img produc
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(text:  product.description // discreption product
                  ,)
                ),
              ],
            ),
          ) 
        ],
      ),
      bottomNavigationBar:  GetBuilder<RecommandedProductConroller>(builder: (recommandedProduct){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                        recommandedProduct.setQuantity(false);
                      },
                  child: AppIcon(
                    iconSize: Dimensions.icon24,
                    iconColor: Colors.white, 
                    backgroundColor: AppColors.mainColor, 
                    icon: Icons.remove                                //icon remove
                  ),
                ),
                BigText(
                  text: "\$ ${product.price!} " + " X " + recommandedProduct.inCartItems.toString(),     // the number
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                GestureDetector(
                  onTap: (){
                        recommandedProduct.setQuantity(true);
                      },
                  child: AppIcon(
                    iconSize: Dimensions.icon24,
                    iconColor: Colors.white, 
                    backgroundColor: AppColors.mainColor, 
                    icon: Icons.add                             // icon add
                    ),
                ),
              ],
            ),
          ),
            Container(
               padding: EdgeInsets.only(
              left: Dimensions.width10,
              right: Dimensions.width10,
              top: Dimensions.height10,
              bottom: Dimensions.height10
            ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )
                  
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                  ),
                  child: GestureDetector(
                    onTap: (){
                      recommandedProduct.addItem(product);
                    },
                    child: BigText(text: "\$ ${product.price!} | Add to cart")
                  ),          //
                )
              ],
                      ),
            ),
        ],
      );})
    );
  }
}