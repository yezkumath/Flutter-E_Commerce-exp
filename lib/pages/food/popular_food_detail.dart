import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/controllers/popular_product_controller.dart';
import 'package:e_commer/pages/cart/cart_page.dart';
import 'package:e_commer/pages/home/main_food_page.dart';
import 'package:e_commer/routes/route_helper.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:e_commer/utils/dimensions.dart';
import 'package:e_commer/widget/app_column.dart';
import 'package:e_commer/widget/app_icon.dart';
import 'package:e_commer/widget/big_text.dart';
import 'package:e_commer/widget/expandable_text_widget.dart';
import 'package:e_commer/widget/icon_and_text_widget.dart';
import 'package:e_commer/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
  PopularFoodDetail({ Key? key,
    required this.pageId,
    required this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductConroller>().PopularProductList[pageId];
    Get.find<PopularProductConroller>().initProduct(product, Get.find<CartController>());
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // bacground image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                   AppConstrants.BASE_URL + AppConstrants.UPLOAD + product.img! // img product
                )
                )
              ),
            )
            ),
            // icon Widget on bacground image
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){

                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                      else{
                         Get.toNamed(RouteHelper.initial);
                      }
                     
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)
                    ),
                 GetBuilder<PopularProductConroller>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItem>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children :[
                        AppIcon(icon: Icons.shopping_cart_outlined),
                       controller.totalItem>=1?
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
                        controller.totalItem>=1?
                          Positioned(
                            right: 6,
                            top: 3,
                            child: BigText(
                              text:controller.totalItem.toString(),
                              size: 12,
                              color: Colors.white,
                            ),
                          ):
                          Container()
                      ]
                    ),
                  );
                 })
                ],
              )
            ),
            //introduction of food
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20, 
                  right: Dimensions.width20, 
                  top: Dimensions.height20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name), // name product
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height45),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                          text: product.description // discription product
                        )
                      )
                    )
                  ],
                )
              )
            ),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductConroller>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHightBar,
          padding: EdgeInsets.only(
            top: Dimensions.height30, 
            bottom: Dimensions.height30, 
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2)
            ),
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,) // minus icon
                    ),
                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: popularProduct.inCartItems.toString()), // the number
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor,) // add icon
                    )
                  ],
                ),
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
                    popularProduct.addItem(product);
                  },
                  child: BigText(text: "\$ ${product.price!}  | Add to cart")
                ),
              )
            ],
          ),
        );
      })
    );
  }
}