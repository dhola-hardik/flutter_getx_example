import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_example/controllers/app_controller.dart';
import 'package:flutter_getx_example/data/common/params_args.dart';
import 'package:flutter_getx_example/models/product_model.dart';
import 'package:flutter_getx_example/res/app_color.dart';
import 'package:flutter_getx_example/res/strings.dart';
import 'package:flutter_getx_example/src/my_cart.dart';
import 'package:flutter_getx_example/utils/log_util.dart';
import 'package:flutter_getx_example/utils/my_application.dart';
import 'package:flutter_getx_example/utils/widget_util.dart';
import 'package:flutter_getx_example/widgets/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'favourite_products.dart';
import 'widgets/item_product.dart';

final title = "HomePage";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return CustomAppBar(
      showLeadingArrow: false,
      centerTitle: false,
      showTitleSpacing: true,
      title: strings.welcome,
      actionsWidget: [
        Obx(() {
          return Badge(
            position: BadgePosition.topEnd(top: 10.w, end: 10.w),
            animationType: BadgeAnimationType.scale,
            animationDuration: Duration(milliseconds: 300),
            badgeColor: Colors.white,
            showBadge: MyApplication.appController.favouriteList.length > 0,
            badgeContent: Text(
                "${MyApplication.appController.favouriteList.length}",
                style: TextStyle(
                    fontSize: 32.sp,
                    color: appColor.main,
                    fontWeight: FontWeight.w700)),
            child: IconButton(
              icon: Icon(Icons.favorite_border_rounded),
              onPressed: () {
                Get.to(FavouriteProducts());
              },
            ),
          );
        }),
        Obx(() {
          return Badge(
            position: BadgePosition.topEnd(top: 3, end: 3),
            animationType: BadgeAnimationType.scale,
            animationDuration: Duration(milliseconds: 300),
            badgeColor: Colors.white,
            badgeContent: Text("${MyApplication.appController.cartList.length}",
                style: TextStyle(
                    fontSize: 32.sp,
                    color: appColor.main,
                    fontWeight: FontWeight.w700)),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_rounded),
              onPressed: () {
                Get.to(MyCart());
              },
            ),
          );
        }),
        WidgetUtil.spaceHorizontal(20),
      ],
    );
  }

  Widget _buildBody() {
    return Obx(() {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 20.w),
              itemCount: MyApplication.appController.productsList.length,
              itemBuilder: (context, index) {
                final data = MyApplication.appController.productsList[index];
                return ItemProduct(
                  data: data,
                  onQtyAdd: () {
                    MyApplication.appController.updateQty(product: data);
                  },
                  onQtyMin: () {
                    if (data.qty > 0) {
                      MyApplication.appController
                          .updateQty(product: data, isAdd: false);
                    }
                  },
                );
              },
            ),
          ),
          if (MyApplication.appController.cartList.isNotEmpty)
            _buildCartTotal(),
        ],
      );
    });
  }

  Widget _buildCartTotal() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: appColor.main.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: appColor.main.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 10,
            offset: Offset(0, 7),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 70.w),
      child: Column(
        children: [
          WidgetUtil.spaceVertical(10),
          Row(
            children: [
              Expanded(
                child: Text(strings.total,
                    style: TextStyle(
                        color: appColor.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 50.sp)),
              ),
              Text(
                  "\$${MyApplication.appController.cartDetailsMap[ParamsArgus.KEY_CART_TOTAL]}",
                  style: TextStyle(
                      color: appColor.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 50.sp)),
            ],
          ),
          WidgetUtil.spaceVertical(40),
          ElevatedButton.icon(
            onPressed: () {
              Get.to(MyCart());
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 100.w, vertical: 25.w)),
            icon: Icon(Icons.shopping_cart_rounded, color: appColor.main),
            label: Text(strings.continue_,
                style: TextStyle(
                    color: appColor.main,
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp)),
          ),
        ],
      ),
    );
  }
}
