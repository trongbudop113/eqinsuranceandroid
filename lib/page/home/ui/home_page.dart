
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/page/home/controller/home_controller.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/string_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/button_widget.dart';
import 'package:eqinsuranceandroid/widgets/icon_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(flex: 1),
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                          child: Image.asset(ImageResource.ic_settings, width: 20, height: 20)
                      ),
                      onTap: (){
                        Get.toNamed(GetListPages.SETTINGS);
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                      ),
                      onTap: (){
                        controller.getContactInfo();
                      },
                    ),
                    SizedBox(width: 10),
                    Obx(() => IconNotificationWidget(
                      onTap: (){
                        Get.toNamed(GetListPages.NOTIFICATION);
                      },
                      count: controller.countNotify.value,
                      isShowNotification: controller.isShowNotification.value,
                    ),)
                  ],
                ),
                SizedBox(height: 20),
                Image.asset(ImageResource.logo1, width: Get.width * 0.5),

                Spacer(flex: 1),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    StringResource.thank_you,
                    textAlign: TextAlign.center,
                    style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 14),
                  ),
                ),
                Obx(() => Column(
                  children: [
                    Visibility(
                      visible: controller.isPublicUser.value,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Visibility(
                          visible: controller.isPublicUserType.value == 0,
                          child: ButtonWidget.buttonBorder(context, "Public Users", onTap: (){
                            controller.getPublicUser();
                          }),
                          replacement: ButtonWidget.buttonNormal(context, "Public Users", onTap: (){
                            controller.getPublicUser();
                          })
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.isPartner.value,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Visibility(
                          visible: controller.isPartnerType.value == 0,
                          child: ButtonWidget.buttonBorder(context,  "Partners", onTap: (){
                            controller.goToPartnerPage();
                          }),
                          replacement: ButtonWidget.buttonNormal(context, "Partners", onTap: (){
                            controller.goToPartnerPage();
                          }),
                        ),
                      )
                    ),
                    Visibility(
                        visible: controller.isPartnerCustomer.value,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Visibility(
                            visible: controller.isPartnerCustomerType.value == 0,
                            child: ButtonWidget.buttonBorder(context,  "Partner Customer", onTap: (){
                              controller.goToPartnerCustomer();
                            }),
                            replacement: ButtonWidget.buttonNormal(context, "Partner Customer", onTap: (){
                              controller.goToPartnerCustomer();
                            }),
                          )
                        )
                    ),
                  ],
                ))
              ],
            ),
          ),
          Obx(() => LoadingPage(isLoading: controller.isLoading.value))
        ],
      ),
    );
  }

}