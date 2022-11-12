import 'package:eqinsuranceandroid/page/athentication/controller/authentication_controller.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPage extends GetView<AuthenticationController>{
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResource.color_appbar_settings,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 15),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              child: Image.asset(ImageResource.ic_exit, width: 30, color: Colors.white,),
            ),
          ),
          SizedBox(width: 30),
          Container(
            child: Text("Digital Token", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            alignment: Alignment.center,
          ),
          Spacer(flex: 1),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Icon(Icons.info_outline, color: Colors.white, size: 25),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageResource.bg),
                      fit: BoxFit.fill
                  )
              ),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(7),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Obx(() => Visibility(
                    visible: controller.isShowView.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You\'re Accessing our ', style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 30, color: ColorResource.color_title_authen)),
                        Text('Customer Portal', style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: ColorResource.color_title_authen)),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: (){
                            controller.requestToApprove();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(ImageResource.ic_approve_button, width: 233),
                          ),
                        ),

                        SizedBox(height: 50),
                        Text('Not initiated by you?', style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 18, color: ColorResource.color_title_authen)),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            controller.requestToReject();
                          },
                          child: Container(
                              width: 140,
                              height: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(color: ColorResource.color_title_authen)
                              ),
                              child: Text("Reject", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold, color: ColorResource.color_title_authen))
                          ),
                        ),
                      ],
                    ),
                    replacement: Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(controller.imageApproved.value, width: 170),
                        SizedBox(height: 10),
                        Text(controller.textAuthenticated.value, style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_authen)),
                      ],
                    )),
                  )),
                ),
              )
          ),
          Obx(() => LoadingPage(isLoading: controller.isLoading.value))
        ],
      ),
    );
  }

}