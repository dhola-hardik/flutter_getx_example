import 'package:flutter/material.dart';
import 'package:flutter_getx_example/data/common/params_args.dart';
import 'package:flutter_getx_example/res/app_color.dart';
import 'package:flutter_getx_example/res/images.dart';
import 'package:flutter_getx_example/res/strings.dart';
import 'package:flutter_getx_example/utils/my_application.dart';
import 'package:flutter_getx_example/utils/widget_util.dart';
import 'package:flutter_getx_example/widgets/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/item_my_cart.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: strings.my_cart),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (MyApplication.appController.cartList.isEmpty) {
        return Center(
          child: Image.asset(images.ic_empty_cart, height: 200),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 20.w),
              itemCount: MyApplication.appController.cartList.length,
              itemBuilder: (context, index) {
                final data = MyApplication.appController.cartList[index];
                return ItemMyCart(
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 100.w, vertical: 25.w)),
            icon: Icon(Icons.shopping_cart_rounded, color: appColor.main),
            label: Text(strings.checkout,
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
