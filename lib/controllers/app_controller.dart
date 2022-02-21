import 'package:flutter_getx_example/data/common/params_args.dart';
import 'package:flutter_getx_example/models/product_model.dart';
import 'package:flutter_getx_example/utils/log_util.dart';
import 'package:get/get.dart';

final title = "AppController";

class AppController extends GetxController {
  /// made this if you need cancel you worker
  late Worker _ever;

  var _cartDetailsMap = Map<String, dynamic>().obs;
  var _productsList = <ProductModel>[].obs;
  var _cartList = <ProductModel>[].obs;
  var _favouriteList = <ProductModel>[].obs;
  var _favCount = 0.obs;

  List<ProductModel> get productsList => _productsList.value;

  List<ProductModel> get cartList => _cartList.value;

  List<ProductModel> get favouriteList => _favouriteList.value;

  int get favCount => _favCount.value;

  Map<String, dynamic> get cartDetailsMap => _cartDetailsMap.value;

  @override
  void onInit() {
    Log.loga(title, "onInit:: >>>>>>> ");
    _initProducts();
    super.onInit();

    /*
    /// Called every time the variable $_ is changed
    _ever = ever(_cartList, (_) => {Log.loga(title, "onInit:: _cartList >>>>> ")});
    everAll([count1, count2], (_) => print("$_ has been changed (everAll)"));

    /// Called first time the variable $_ is changed
    once(count1, (_) => print("$_ was changed once (once)"));

    /// Anti DDos - Called every time the user stops typing for 1 second, for example.
    debounce(count1, (_) => print("debouce$_ (debounce)"),
        time: Duration(seconds: 1));

    /// Ignore all changes within 1 second.
    interval(count1, (_) => print("interval $_ (interval)"),
        time: Duration(seconds: 1));*/
  }

  void _initProducts() async {
    List<ProductModel> products = await ProductModel.getProducts();
    _productsList.addAll(products);
    Log.loga(
        title, "_initProducts:: _productsList >>>>>>> ${_productsList.length}");
  }

  disposeWorker() {
    _ever.dispose();
    // or _ever();
  }

  void updateQty({
    required ProductModel product,
    bool isAdd = true,
  }) {
    int index = _productsList.indexOf(product);
    if (isAdd) {
      product.qty++;
      _productsList[index] = product;

      addItemToCart(product: product);
    } else {
      product.qty--;
      _productsList[index] = product;

      removeItemFromCart(product: product);
    }
  }

  // cart
  void addItemToCart({required ProductModel product}) {
    if (product.qty > 1) {
      _cartList.indexOf(product);
      // OR
      // _cartList[_cartList.indexOf(product)] = product;
    } else {
      _cartList.add(product);
    }

    _updateCart();
  }

  void removeItemFromCart({required ProductModel product}) {
    if (product.qty < 1) {
      _cartList.remove(product);
    } else {
      _cartList.indexOf(product);
      // OR
      // _cartList[_cartList.indexOf(product)] = product;
    }

    _updateCart();
  }

  void deleteProductFromCart({required ProductModel product}) {
    int index = _productsList.indexOf(product);
    product.qty = 0;
    _productsList[index] = product;

    removeItemFromCart(product: product);
  }

  void _updateCart() {
    _cartDetailsMap.update(
        ParamsArgus.KEY_CART_ITEMS, (dynamic val) => _cartList.length,
        ifAbsent: () => _cartList.length);

    double total = 0;
    _cartList.forEach((product) {
      total += (product.price ?? 0) * product.qty;
    });

    _cartDetailsMap.update(
        ParamsArgus.KEY_CART_TOTAL, (dynamic val) => total.toStringAsFixed(2),
        ifAbsent: () => total.toStringAsFixed(2));
  }

  void clearCart() {
    _cartList.clear();
    _cartDetailsMap.update(ParamsArgus.KEY_CART_ITEMS, (dynamic val) => 0,
        ifAbsent: () => 0);
    _cartDetailsMap.update(ParamsArgus.KEY_CART_TOTAL, (dynamic val) => 0,
        ifAbsent: () => 0);
  }

  // fav-unfav products
  void setFavourite({
    required ProductModel product,
    required bool fav,
  }) {
    product.isFav = fav;
    _productsList[_productsList.indexOf(product)] = product;
    Log.loga(title, "setFavourite:: >>>>> ${product.toJson()}");

    if (fav) {
      _favouriteList.add(product);
      // _favCount++;
    } else {
      _favouriteList.remove(product);
      // _favCount--;
    }
  }
}
