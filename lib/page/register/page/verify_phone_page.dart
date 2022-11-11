import 'package:eqinsuranceandroid/page/register/controller/register_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifyPhonePage extends StatelessWidget {
  final RegisterController controller;
  const VerifyPhonePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller.onBackPress();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(ImageResource.ic_back, width: 12,),
                          ),
                        ),
                        Spacer(flex: 1),
                        Text("Verification", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.page_title_textColor, fontWeight: FontWeight.bold)),
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
                              text: 'Phone Number',
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.color_title_popup),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'In order to protect the security of your account, we would need you to verify your mobile phone number. We will send you a text message with the verification code that you will need to enter on the next screen.',
                          style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Location'
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: (){
                          controller.showDialogSelectCountryCode();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),
                          height: 38,
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Image.asset(ImageResource.location, height: 12),
                              SizedBox(width: 12),
                              Expanded(
                                flex: 10,
                                child: Obx(() => Text(
                                  controller.textLocationPhone.value,
                                  style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.plaintext_textColor),
                                )),
                              ),
                              Container(
                                height: 25,
                                width: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_drop_down, color: Colors.black, size: 20),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Phone'
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Obx(() => Container(
                            height: 38,
                            width: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                            ),
                            child: Text(
                               "+" + controller.textCountryCodePhone.value,
                              style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.plaintext_textColor),
                            ),
                          )),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.phoneNumberText,
                              onSubmit: (value){

                              },
                              textInputType: TextInputType.number,
                              inputFormatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly

                              ],
                              hint: "Enter phone number",
                            ),
                          )
                        ],
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
            child: ButtonWidget.buttonNormal(context, 'Next', onTap: (){
              controller.onSubmitVerifyPhoneNumber();
              //controller.onFocusPage(2);
            }),
          )
        ],
      ),
    );
  }
}
