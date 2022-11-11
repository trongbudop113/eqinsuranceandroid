
import 'package:eqinsuranceandroid/page/settings/controller/settings_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingsPage extends GetView<SettingsController>{
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.color_bg_settings,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResource.color_appbar_settings,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 20),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Image.asset(ImageResource.arrow_back_notification, width: 20)
            ),
            onTap: (){
              Get.back();
            },
          ),
          SizedBox(width: 20),
          Container(
            alignment: Alignment.center,
            child: Text("Settings", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Spacer(flex: 1),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(7),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset(ImageResource.ic_settings_big, width: 100, height: 100,),
              SizedBox(height: 15),
              Text('Reset App Settings'.toUpperCase(),
                style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "By clicking on the Yes button, this will permanently delete the app's data on this device, including your preference and sign-in details.",
                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Text.rich(
                TextSpan(
                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: 'Do you want to clear the '),
                    TextSpan(
                      text: 'User Data?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ButtonWidget.buttonNormal(context, "Yes", onTap: (){
                controller.onClickYes();
              }),
              SizedBox(height: 10),
              ButtonWidget.buttonBorder(context, "No", onTap: (){
                controller.onCLickNo();
              })
            ],
          ),
        ),
      ),
    );
  }

}