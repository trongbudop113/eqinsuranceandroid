import 'package:eqinsuranceandroid/page/change_sc/controller/change_sc_controller.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChangeSCPage extends GetView<ChangeSCController>{
  const ChangeSCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.hideKeyboard(context: context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
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
                  SizedBox(height: 25),
                  Container(
                      width: double.maxFinite,
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
                              child: Image.asset(ImageResource.ic_back, width: 12,),
                            ),
                          ),
                          Spacer(flex: 1),
                          Text("Change Security Code", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.page_title_textColor, fontWeight: FontWeight.bold)),
                          Spacer(flex: 1),
                          SizedBox(width: 22)
                        ],
                      )
                  ),
                  SizedBox(height: 20),
                  Image.asset(ImageResource.logo0, width: 50),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 22, color: ColorResource.page_title_textColor),
                      children: [
                        TextSpan(text: 'Change '),
                        TextSpan(
                          text: 'Security Code',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.color_title_popup),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Follow the steps below to change your Security Code.',
                    textAlign: TextAlign.center,
                    style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Current Security Code',
                      style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFieldWidget(onSubmit: (value){

                  }, hint: "Enter Current Security Code",
                    obscureText: true,
                    textInputType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly

                    ],
                    controller: controller.currentScText,
                  ),

                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Security Code',
                      style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFieldWidget(onSubmit: (value){

                  }, hint: "Enter New Security Code",
                    obscureText: true,
                    textInputType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly

                    ],
                    controller: controller.newScText,
                  ),

                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm New Security Code',
                      style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFieldWidget(onSubmit: (value){

                  }, hint: "Confirm New Security Code",
                    obscureText: true,
                    textInputType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly

                    ],
                    controller: controller.confirmScText,
                  ),

                  Spacer(flex: 1),
                  ButtonWidget.buttonNormal(context, 'Update', onTap: (){
                    controller.onSubmitChangeSC();
                  })
                ],
              ),
            ),
            Obx(() => LoadingPage(isLoading: controller.isLoading.value))
          ],
        ),
      ),
    );
  }

}