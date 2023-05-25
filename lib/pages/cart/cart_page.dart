import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/controllers/popular_product_controller.dart';
import 'package:e_commer/controllers/recommanded_product_controller.dart';
import 'package:e_commer/pages/home/main_food_page.dart';
import 'package:e_commer/routes/route_helper.dart';
import 'package:e_commer/utils/app_constants.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:e_commer/utils/dimensions.dart';
import 'package:e_commer/widget/app_icon.dart';
import 'package:e_commer/widget/big_text.dart';
import 'package:e_commer/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.icon24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.icon24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.icon24,
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height10),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: GetBuilder<CartController>(builder: (CartController) {
                    var _cartList = CartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: Dimensions.height20 * 5,
                            width: double.maxFinite,
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                        Get.find<PopularProductConroller>()
                                            .PopularProductList
                                            .indexOf(_cartList[index].product!);

                                    var recommandedIndex =
                                        Get.find<RecommandedProductConroller>()
                                            .RecommandedProductList
                                            .indexOf(_cartList[index].product!);

                                    if (popularIndex >= 0) {
                                      Get.toNamed(RouteHelper.getPopularFood(
                                          popularIndex, "cartpage"));
                                    } else if (recommandedIndex >= 0) {
                                      Get.toNamed(
                                          RouteHelper.getRecommandedFood(
                                              recommandedIndex, "cartpage"));
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.height20 * 5,
                                    height: Dimensions.height20 * 5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstrants.BASE_URL +
                                                    AppConstrants.UPLOAD +
                                                    _cartList[index].img!)),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                    child: Container(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: _cartList[index].name!,
                                        color: Colors.black54,
                                      ), //  nama menu
                                      SmallText(
                                        text: "Spicy",
                                        color: Colors.grey,
                                      ), // lokasi keterangan
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: "\$ " +
                                                  _cartList[index]
                                                      .price!
                                                      .toString(),
                                              color: Colors.redAccent,
                                            ), // lokasi harga
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        CartController.addItems(
                                                            _cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ) // minus icon
                                                      ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  BigText(
                                                      text: _cartList[index]
                                                          .quantity
                                                          .toString()), // the number
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  GestureDetector(
                                                      onTap: () {
                                                        CartController.addItems(
                                                            _cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ) // add icon
                                                      )
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        });
                  }),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
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
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      BigText(
                          text: "\$ " +
                              cartController.totalAmount
                                  .toString()), // the number
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                  child: GestureDetector(
                      onTap: () {
                        //popularProduct.addItem(product);
                        cartController.addToHistory();
                        print("type");
                      },
                      child: BigText(text: "Check Out")),
                )
              ],
            ),
          );
        }));
  }
}
