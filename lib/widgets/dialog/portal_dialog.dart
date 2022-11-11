import 'package:eqinsuranceandroid/page/athentication/controller/authentication_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortalDialog extends StatefulWidget {
  final AuthenticationController authenticationController;
  const PortalDialog({required this.authenticationController});
  @override
  _PortalDialogState createState() => _PortalDialogState();
}

class _PortalDialogState extends State<PortalDialog> with SingleTickerProviderStateMixin {

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
              height: Get.width * 0.9,
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageResource.ic_complete_step_3, width: 70),
                      SizedBox(height: 10),
                      Text("You have successfully Authorized", style: StyleResource.TextStyleBlack(context)
                          .copyWith(fontSize: 18, color: ColorResource.color_title_authen, fontWeight: FontWeight.bold)),
                      Text("Please return to Customer Portal", style: StyleResource.TextStyleBlack(context)
                          .copyWith(fontSize: 16, color: ColorResource.color_title_authen)),
                      SizedBox(height: 40),
                      ButtonWidget.buttonNormal(
                          context,
                          "Done",
                        radius: 30,
                        onTap: (){
                          Get.back();
                        }
                      )
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