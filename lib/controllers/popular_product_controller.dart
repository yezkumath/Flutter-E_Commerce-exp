import 'package:e_commer/controllers/cart_controller.dart';
import 'package:e_commer/data/repository/popular_product_repo.dart';
import 'package:e_commer/models/cart_model.dart';
import 'package:e_commer/models/products_model.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductConroller extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductConroller({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get PopularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      print("increment ++");
      _quantity = checkQuantity(_quantity + 1);
    } else {
      print("decrement--");
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar(
        "Item Count",
        "You can't reduce more than 0",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar(
        "Item Count",
        "You can't increas more than 20",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    print("init");
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    print("exist or not " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //print("quantity is "+_inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItems((product), _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItem {
    return _cart.totalItem;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
