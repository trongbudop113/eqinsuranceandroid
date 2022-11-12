import 'dart:async';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/webview/models/notification_detail_req.dart';
import 'package:eqinsuranceandroid/page/webview/models/update_device_req.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

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

  ApiProvider apiProvider = ApiProvider();

  String fireBaseKey = "", requestTokenUrl = "", completeTokenUrl = "", apiUsername = "", apiKey = "";

  @override
  void onInit() {
    super.onInit();
    getIntentParam();
    initCheckUserID();
  }

  Future<void> initCheckUserID() async {
    isLoading.value = true;
    String userId =  await SharedConfigName.getUserID();
    String token =  await SharedConfigName.getTokenFirebase();
    if (userId != '' && !userId.isEmpty){
      requestToGetAPIInfo(token);
    }
    isLoading.value = true;
  }

  Future<void> requestToGetAPIInfo(String token) async {
    try{
      NotificationDetailReq notificationDetailReq = NotificationDetailReq();
      notificationDetailReq.sUserName = ConfigData.CONSUMER_KEY;
      notificationDetailReq.sPassword = ConfigData.CONSUMER_SECRET;
      notificationDetailReq.sEnvironment = ConfigData.EVR_CODE;

      var response = await apiProvider.fetchData(ApiName.GetNotificationDetails, notificationDetailReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          var temValues = data.split("\|");
          //for (String item in temValues)

          fireBaseKey = temValues[0];
          requestTokenUrl = temValues[1];
          completeTokenUrl = temValues[2];
          apiUsername = temValues[3];
          apiKey = temValues[4];
          if(token != ""){
            //EncryptionData.encryptData(apiUsername + "|" + token, apiKey);
            // final key = keyLib.Key.fromUtf8(apiKey);
            // final encrypter = Encrypter(AES(key));
            // //var IV = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            //
            // final iv = IV.fromSecureRandom(16);
            // final String requestKey = encrypter.encrypt(apiUsername + "|" + token, iv: iv).base64;
            // print("requestKey......" + requestKey);
            // requestToUpdateDeviceAPI(requestKey);
          }
        }
      }
    }catch(e){
      isLoading.value = false;
    }
  }

  Future<void> requestToUpdateDeviceAPI(String requestKey) async {
    try{
      final String requestKeyCopy = requestKey;
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));
      String userID = await SharedConfigName.getUserID();

      UpdateDeviceReq updateDeviceReq = UpdateDeviceReq();
      updateDeviceReq.ClientId = apiUsername;
      updateDeviceReq.RequestKey = requestKeyCopy;
      updateDeviceReq.Username = userID;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/UpdateUserDevice", updateDeviceReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        String data = root.children[2].children.first.toString();

        print("data....." +data);

      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
    }
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