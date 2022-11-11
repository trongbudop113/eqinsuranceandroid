import 'package:eqinsuranceandroid/page/register/controller/register_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyUserPage extends StatelessWidget {
  final RegisterController controller;
  const VerifyUserPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller.onBackPress();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(ImageResource.ic_back, width: 12,),
                          ),
                        ),
                        Spacer(flex: 1),
                        Text("User Account", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.page_title_textColor, fontWeight: FontWeight.bold)),
                        Spacer(flex: 1),
                        SizedBox(width: 17),
                      ],
                    )
                ),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset(ImageResource.logo0, width: 50),

                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 22, color: ColorResource.page_title_textColor),
                          children: [
                            TextSpan(text: 'Verify your '),
                            TextSpan(
                              text: 'User Account',
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.color_title_popup),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Please key in your existing User ID and Password to verify your user account.  Your user ID is the same login ID as the EQI Partners e-portal.',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'User ID',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFieldWidget(
                        controller: controller.userIDText,
                        onSubmit: (value){
                          //controller.onChangeUserName(value);
                        },
                        hint: "Enter User ID",
                        isShowLeftIcon: true,
                        leftIcon: ImageResource.user,
                      ),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Password',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFieldWidget(
                        controller: controller.userPasswordText,
                        onSubmit: (value){
                          //controller.onChangePassword(value);
                        },
                        obscureText: true,
                        hint: "Enter Password",
                        isShowLeftIcon: true,
                        leftIcon: ImageResource.lock,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 15,
            right: 15,
            child: Container(
              child: ButtonWidget.buttonNormal(context, 'Next', onTap: (){
                controller.onSubmitUserAccount();
                //controller.onFocusPage(1);
              }),
            ),
          )
        ],
      ),
    );
  }
}
