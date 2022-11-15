import 'package:eqinsuranceandroid/page/contact_us/controller/contact_us_controller.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/resource/color_resource.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/resource/style_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsPage extends GetView<ContactUsController>{
  const ContactUsPage({Key? key}) : super(key: key);

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
                        SizedBox(width: 15),
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
                        Text("Contact Us", style: StyleResource.TextStyleBlack(context).copyWith(fontSize: 19, fontWeight: FontWeight.bold, color: ColorResource.color_content_popup)),
                        Spacer(flex: 1),
                        SizedBox(width: 37),
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
                    navigationDelegate: (NavigationRequest request) {
                      if(controller.checkNavigatorLink(request.url)){
                        return NavigationDecision.navigate;
                      }
                      controller.onCheckLink(request.url);
                      return NavigationDecision.prevent;
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                    onPageStarted: (String url) {
                      controller.isLoading.value = true;
                      print('Page started loading: $url');
                      NavigationDecision.navigate;
                      controller.onCheckLink(url);
                    },
                    onPageFinished: (String url) {
                      controller.isLoading.value = false;
                      print('Page finished loading: $url');
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