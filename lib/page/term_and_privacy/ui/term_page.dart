
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/page/term_and_privacy/controller/term_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/string_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermPage extends GetView<TermController>{
  const TermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage(ImageResource.bg),
                fit: BoxFit.fill
            )
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(ImageResource.logo1, width: Get.width * 0.5),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                StringResource.code_for_access,
                textAlign: TextAlign.center,
                style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 13, color: Colors.black),
              ),
            ),

            Spacer(flex: 1),
            Text(
              StringResource.tap_on,
              textAlign: TextAlign.center,
              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.link_text_grey),
            ),
            SizedBox(height: 2),
            GestureDetector(
              onTap: (){
                controller.openTermAndPolicyPage();
              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  StringResource.eq_term,
                  textAlign: TextAlign.center,
                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, decoration: TextDecoration.underline, color: ColorResource.link_text),
                ),
              ),
            ),
            SizedBox(height: 18),

            ButtonWidget.buttonNormal(context, "Agree and Continue", onTap: (){
              controller.setAgreeTerm();
            })
          ],
        ),
      ),
    );
  }

}