import 'package:eqinsuranceandroid/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewSCPage extends StatelessWidget {
  final ForgetSCController controller;
  const NewSCPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
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
                           'For better privacy protection, you are required to set a 6 Digit number security code below. You will need to enter this security code for all future login purposes.',
                           style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: Colors.black),
                           textAlign: TextAlign.center,
                         ),
                       ),

                       SizedBox(height: 30),
                       Container(
                         alignment: Alignment.centerLeft,
                         child: Text(
                           'Security Code',
                           style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                         ),
                       ),
                       SizedBox(height: 8),
                       TextFieldWidget(onSubmit: (value){

                       }, hint: "Enter Security Code",
                           obscureText: true,
                           textInputType: TextInputType.number,
                           inputFormatter: <TextInputFormatter>[
                             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                             FilteringTextInputFormatter.digitsOnly

                           ],
                           controller: controller.scText,
                           isShowLeftIcon: true,
                           leftIcon: ImageResource.key
                       ),

                       SizedBox(height: 10),
                       Container(
                         alignment: Alignment.centerLeft,
                         child: Text(
                           'Confirm Security Code',
                           style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14, color: ColorResource.color_title_popup),
                         ),
                       ),
                       SizedBox(height: 8),
                       TextFieldWidget(onSubmit: (value){

                       }, hint: "Confirm Security Code",
                           obscureText: true,
                           textInputType: TextInputType.number,
                           inputFormatter: <TextInputFormatter>[
                             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                             FilteringTextInputFormatter.digitsOnly

                           ],
                           controller: controller.confirmSCText,
                           isShowLeftIcon: true,
                           leftIcon: ImageResource.key
                       ),
                     ],
                   ),
                 )

                ],
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: ButtonWidget.buttonNormal(context, "Next", onTap: (){
                controller.onSubmitSCCode();
              }),
            )
          ],
        )
    );
  }
}
