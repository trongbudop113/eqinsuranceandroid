import 'dart:async';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

  bool checkNavigatorLink(String link){
    if(link.startsWith("tel:")){
      return false;
    }else if(link.endsWith(".pdf") || link.endsWith(".doc")
        || link.endsWith(".docx")
        || link.endsWith(".xls")
        || link.endsWith(".xlsx")){
      return false;
    }else if(link.contains("mailto")){
      return false;
    }else{
      return true;
    }
  }

  Future<void> onCheckLink(String link) async {
    print("link:....." + link);
    if(link.startsWith("tel:")){
      bool canLaunch = await canLaunchUrlString(link);
      if(canLaunch){
        launchUrlString(link);
      }
    }else if(link.endsWith(".pdf") || link.endsWith(".doc")
        || link.endsWith(".docx")
        || link.endsWith(".xls")
        || link.endsWith(".xlsx")){
      downloadFile(link);
    }else if(link.contains("mailto:")){
      launchUrlString(link);
    }
  }

  Future<void> downloadFile(String url) async {
    await launch(url);
  }

  Future<void> onReload() async {

  }

}