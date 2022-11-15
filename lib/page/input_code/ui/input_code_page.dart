
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/page/input_code/controller/input_code_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputCodePage extends GetView<InputCodeController>{
  const InputCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: Get.height,
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
                  SizedBox(height: 10),
                  Container(
                      width: double.maxFinite,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: 22,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(ImageResource.ic_back, width: 12),
                            ),
                          ),
                          Spacer(flex: 1),
                        ],
                      )
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(ImageResource.logo1, width: Get.width * 0.5),

                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Security Code',
                            style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFieldWidget(onSubmit: (value){

                        }, hint: "Enter Current Security Code",
                            controller: controller.scText,
                            isShowLeftIcon: true,
                            leftIcon: ImageResource.key),

                      ],
                    ),
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(GetListPages.FORGET_SC);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                              'Forget Security Code',
                              style: StyleResource.TextStyleBlack(context).copyWith(
                                  decoration: TextDecoration.underline,
                                  color: ColorResource.link_text,
                                fontSize: 15
                              )
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(GetListPages.CHANGE_SC);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                              'Change Security Code',
                              style: StyleResource.TextStyleBlack(context).copyWith(
                                decoration: TextDecoration.underline,
                                  color: ColorResource.link_text_grey,
                                fontSize: 15
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 10),
                  ButtonWidget.buttonNormal(context, "Next", onTap: (){
                    controller.onSubmitLoginAgentCode();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: (){
        controller.hideKeyboard(context: context);
      },
    );
  }

}