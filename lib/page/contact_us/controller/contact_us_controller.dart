import 'dart:async';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }

}

class ContactUsController extends GetxController{

  final Completer<WebViewController> webViewController = Completer<WebViewController>();

  String url = "";
  bool isContact = false;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getIntentParam();
  }

  void getIntentParam(){
    var data = Get.arguments;
    url = data['link'].toString();
  }

  Future<void> onCheckLink(String link) async {
    if(link.startsWith("tel:")){
      isContact = true;
      bool canLaunch = await canLaunchUrlString(link);
        if(canLaunch){
          launchUrlString(link);
        }
    }else if(link.endsWith(".pdf") || link.endsWith(".doc")
        || link.endsWith(".docx")
        || link.endsWith(".xls")
        || link.endsWith(".xlsx")){
      isContact = true;
      downloadFile(url);
    }
  }

  void downloadFile(String url) {
    launchUrlString(url);
  }

  Future<void> onReload() async {
    if(isContact){
      var web = await webViewController.future;
      await web.loadUrl(url);
      isContact = false;
    }
  }

}