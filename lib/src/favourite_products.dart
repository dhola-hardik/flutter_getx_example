import 'package:flutter/material.dart';
import 'package:flutter_getx_example/res/images.dart';
import 'package:flutter_getx_example/res/strings.dart';
import 'package:flutter_getx_example/utils/my_application.dart';
import 'package:flutter_getx_example/widgets/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/item_product.dart';

class FavouriteProducts extends StatefulWidget {
  @override
  _FavouriteProductsState createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: strings.wishlist),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (MyApplication.appController.favouriteList.isEmpty) {
        return Center(
          child: Image.asset(images.ic_empty_cart, height: 200),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        itemCount: MyApplication.appController.favouriteList.length,
        itemBuilder: (context, index) {
          final data = MyApplication.appController.favouriteList[index];
          return ItemProduct(data: data, fromFav: true);
        },
      );
    });
  }
}
