import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commer/controllers/popular_product_controller.dart';
import 'package:e_commer/controllers/recommanded_product_controller.dart';
import 'package:e_commer/models/products_model.dart';
import 'package:e_commer/pages/food/popular_food_detail.dart';
import 'package:e_commer/routes/route_helper.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:e_commer/utils/dimensions.dart';
import 'package:e_commer/widget/app_column.dart';
import 'package:e_commer/widget/big_text.dart';
import 'package:e_commer/widget/icon_and_text_widget.dart';
import 'package:e_commer/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({ Key? key }) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer; //220

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose(); //to save memory small as posible  need to dispose initial pageController on top
    super.dispose();
  }

  Widget _builtPageItem(int index, ProductModel popularProduct, )
  {
   Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){ // current slide
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor); // this part for aktive/hot to knowing the current slide selected index
      var currTrans = _height*(1-currScale)/2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else if (index == _currPageValue.floor()+1){ //right of current slide
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;

       matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if (index == _currPageValue.floor()-1){ //left of current slide
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;

       matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else { //rest of the slide (because page not on the left and right has original size)
      var currScale = 0.8;
      var currTrans = _height*(1-currScale)/2;

       matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
           GestureDetector(
             onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
             },
             child: Container(
             height: Dimensions.pageViewContainer,//220
             margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
             decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstrants.BASE_URL + AppConstrants.UPLOAD + popularProduct.img!
                  )
                )
              ),
                     ),
           ),
           Align(
             alignment: Alignment.bottomCenter,
             child: Container( // make shadow
              height: Dimensions.pageViewTextContainer,//120
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5) // to set shadow bold and location
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0)
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0)
                  )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
                child: AppColumn(text: popularProduct.name!)
              ),
            ),
           )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --> slider side section
        GetBuilder<PopularProductConroller>(builder: (popularProducts){
          return popularProducts.isLoaded? Container(
              height: Dimensions.pageView,//320
            // color: Colors.red,
              child:  PageView.builder(
                  controller: pageController,
                  itemCount:  popularProducts.PopularProductList.length, // 5 (solid)
                  itemBuilder: (context, position){
                    return _builtPageItem(position, popularProducts.PopularProductList[position]);
                  }
                ),
            ) : CircularProgressIndicator(color: AppColors.mainColor,);
          }
        ),
        
        GetBuilder<PopularProductConroller>(builder: (popularProducts){
          return DotsIndicator(
              dotsCount: popularProducts.PopularProductList.isEmpty?1: popularProducts.PopularProductList.length, // 5 (solid)
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)) 
              ),
            );
          }
        ),


        
        // --> text popular
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                 margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              )
            ]),
        ),
        // --> slider up down section
        
        GetBuilder<RecommandedProductConroller>(builder: (recommandedProducts){
          return recommandedProducts.isLoaded?  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommandedProducts.RecommandedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                  Get.toNamed(RouteHelper.getRecommandedFood(index,"home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        // image section
                        Container(
                          width: Dimensions.listViewImgSize,
                          height:  Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstrants.BASE_URL + AppConstrants.UPLOAD + recommandedProducts.RecommandedProductList[index].img!
                              )
                            )
                          ),
                        ),
                        // text section
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommandedProducts.RecommandedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10),
                                  SmallText(text: recommandedProducts.RecommandedProductList[index].description!),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp, 
                                      iconColor: AppColors.iconColor1, 
                                      text: "Normal",
                                      ),
                                      IconAndTextWidget(
                                      icon: Icons.location_on_sharp, 
                                      iconColor: AppColors.mainColor, 
                                      text: "1.7km",
                                      ),
                                      IconAndTextWidget(
                                      icon: Icons.access_time_sharp, 
                                      iconColor: Color.fromARGB(255, 255, 135, 135), 
                                      text: "32min",
                                      )
                                    ],
                                  )
                                ],
                              ), 
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ) : CircularProgressIndicator(color: AppColors.mainColor,);
          }
        ),

      ],
    );
  }
}