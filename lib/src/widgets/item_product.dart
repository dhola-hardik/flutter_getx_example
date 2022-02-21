import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_example/models/product_model.dart';
import 'package:flutter_getx_example/res/app_color.dart';
import 'package:flutter_getx_example/utils/my_application.dart';
import 'package:flutter_getx_example/utils/widget_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel data;
  final bool fromFav;
  final VoidCallback? onQtyAdd;
  final VoidCallback? onQtyMin;

  ItemProduct({
    required this.data,
    this.onQtyAdd,
    this.onQtyMin,
    this.fromFav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.w, horizontal: 60.w),
      child: Card(
        color: Colors.white,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 30.w),
          child: Row(
            children: [
              ExtendedImage.network(
                data.image ?? "",
                width: 200.w,
                height: 200.w,
                cache: true,
              ),
              WidgetUtil.spaceHorizontal(30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(data.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 38.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                        MaterialButton(
                          onPressed: () {
                            MyApplication.appController
                                .setFavourite(product: data, fav: !data.isFav);
                          },
                          minWidth: 0,
                          padding: EdgeInsets.all(10),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: data.isFav ? Colors.pink : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: appColor.main,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.w),
                          child: Row(
                            children: [
                              Text("${data.rating!.rate}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400)),
                              WidgetUtil.spaceHorizontal(5),
                              Icon(Icons.star_rate_rounded,
                                  color: appColor.white, size: 30.w),
                            ],
                          ),
                        ),
                        WidgetUtil.spaceHorizontal(20),
                        Text("(${data.rating!.count})",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    WidgetUtil.spaceVertical(20),
                    Row(
                      children: [
                        Expanded(
                          child: Text("\$${data.price}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                        if (!fromFav)
                          Row(
                            children: [
                              MaterialButton(
                                  onPressed: onQtyMin,
                                  shape: CircleBorder(),
                                  minWidth: 0,
                                  padding: EdgeInsets.all(5),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Icon(
                                      Icons.indeterminate_check_box_rounded,
                                      size: 75.w,
                                      color: appColor.main)),
                              Container(
                                constraints: BoxConstraints(minWidth: 50.w),
                                child: Text("${data.qty}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 42.sp,
                                        color: appColor.main,
                                        fontWeight: FontWeight.w500)),
                              ),
                              MaterialButton(
                                  onPressed: onQtyAdd,
                                  shape: CircleBorder(),
                                  minWidth: 0,
                                  padding: EdgeInsets.all(5),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Icon(Icons.add_box_rounded,
                                      size: 75.w, color: appColor.main)),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
