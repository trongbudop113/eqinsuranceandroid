import 'package:eqinsuranceandroid/page/notification/models/notification_res.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDialog extends StatefulWidget {
  final NotificationRes data;
  const HomeDialog({required this.data});
  @override
  _HomeDialogState createState() => _HomeDialogState();
}

class _HomeDialogState extends State<HomeDialog> with SingleTickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.bounceInOut);

    controller?.addListener(() {
      setState(() {});
    });

    controller?.forward();
  }

  bool rs = false;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.87,
              color: Colors.transparent,
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                padding: EdgeInsets.all(5),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Visibility(
                        visible: (widget.data.picPath ?? '') != '',
                        child: Image.network(widget.data.picPath ?? ''),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Text(
                            widget.data.subject ?? '',
                            style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup)
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          widget.data.message ?? '',
                          textAlign: TextAlign.center,
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_content_popup)
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Image.asset(ImageResource.popupx, width: 40, height: 40),
                ),
              ),
            )
          ],
        )
    );
  }
}