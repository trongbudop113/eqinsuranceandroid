
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/page/public_user/controller/public_user_controller.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:eqinsuranceandroid/widgets/icon_notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PublicUserPage extends GetView<PublicUserController>{
  const PublicUserPage({Key? key}) : super(key: key);

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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 25),
                Container(
                    width: double.maxFinite,
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Image.asset(ImageResource.ic_back, width: 12),
                          ),
                        ),
                        SizedBox(width: 60),
                        Spacer(flex: 1),
                        Text("EQ Insurance", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 20, color: ColorResource.color_content_popup, fontWeight: FontWeight.bold)),
                        Spacer(flex: 1),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Image.asset(ImageResource.ic_call, width: 20, height: 20),
                                onTap: (){
                                  controller.getContactInfo();
                                  //Get.toNamed(GetListPages.CONTACT_US);
                                },
                              ),
                              SizedBox(width: 10),
                              Obx(() => IconNotificationWidget(
                                onTap: (){
                                  Get.toNamed(GetListPages.NOTIFICATION);
                                },
                                count: controller.countNotify.value,
                                isShowNotification: controller.isShowNotification.value,
                              )),
                              SizedBox(width: 5),
                              GestureDetector(
                                child: Image.asset(ImageResource.home2, height: 18, fit: BoxFit.fitHeight,),
                                onTap: (){
                                  controller.reloadHome();
                                },
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 5),
                        ),
                        SizedBox(width: 15),
                      ],
                    )
                ),
                Expanded(
                  child: WebView(
                    initialUrl: controller.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller.webViewController.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                    onPageStarted: (String url) {
                      controller.isLoading.value = true;
                      print('Page started loading: $url');
                      controller.onCheckLink(url);
                    },
                    onPageFinished: (String url) {
                      controller.isLoading.value = false;
                      print('Page finished loading: $url');
                      controller.onReload();
                    },

                    gestureNavigationEnabled: true,
                    backgroundColor: const Color(0x00000000),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => LoadingPage(isLoading: controller.isLoading.value))
        ],
      ),
    );
  }

}