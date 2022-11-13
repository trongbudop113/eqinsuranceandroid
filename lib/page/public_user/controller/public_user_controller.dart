import 'dart:async';
import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/notification/models/notification_req.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/webview/model/get_contact_req.dart';
import 'package:eqinsuranceandroid/page/webview/models/notification_detail_req.dart';
import 'package:eqinsuranceandroid/page/webview/models/update_device_req.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class PublicUserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PublicUserController());
  }

}

class PublicUserController extends GetxController{
  final Completer<WebViewController> webViewController = Completer<WebViewController>();


  ApiProvider apiProvider = ApiProvider();

  String url = "";
  final RxInt countNotify = 0.obs;
  final RxBool isShowNotification = false.obs;

  final RxBool isLoading = true.obs;
  String fireBaseKey = "", requestTokenUrl = "", completeTokenUrl = "", apiUsername = "", apiKey = "";

  @override
  void onInit() {
    super.onInit();
    getIntentParam();
    refreshNotificationCount();
    initCheckUserID();
  }

  Future<void> initCheckUserID() async {
    String userId =  await SharedConfigName.getUserID();
    String token =  await SharedConfigName.getTokenFirebase();
    if (userId != '' && !userId.isEmpty){
      requestToGetAPIInfo(token);
    }
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
    }catch(e){

    }
  }

  Future<void> getContactInfo() async {
    isLoading.value = true;
    final String _Type = await SharedConfigName.getCurrentUserType();
    String _HpNumberTemp = "";
    if(_Type == ConfigData.PROMO){
      _HpNumberTemp = await SharedConfigName.getPhone();
    }
    final String _HpNumber = _HpNumberTemp;

    GetContactReq getContactReq = GetContactReq();
    getContactReq.sUserName = ConfigData.CONSUMER_KEY;
    getContactReq.sPassword = ConfigData.CONSUMER_SECRET;
    getContactReq.sType = ConfigData.PUBLIC;
    getContactReq.sHpNumber = _HpNumber;


    var response = await apiProvider.fetchData(ApiName.ContactUs, getContactReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      isLoading.value = false;
      Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
    }else{
      isLoading.value = false;
      showErrorMessage("Can not load contact, please try again!");
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void getIntentParam(){
    var data = Get.arguments;
    url = data['link'].toString();
  }

  Future<void> reloadHome() async {
    var web = await webViewController.future;
    await web.loadUrl(url);
  }

  Future<void> refreshNotificationCount() async {

    String agentCode = await SharedConfigName.getAgentCode();
    String userType = await SharedConfigName.getCurrentUserType();

    GetNotificationReq getNotificationReq = GetNotificationReq();
    getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
    getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
    getNotificationReq.sType = userType;
    getNotificationReq.sAgentCode = agentCode;

    var response = await apiProvider.fetchData(ApiName.NotificationCount, getNotificationReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        if(data != "" && data != "0" && data != 0){
          int apiCount = int.tryParse(data) ?? 0;
          List<String> readAndDeletedNotificationIDs = await SharedConfigName.getUserReadNotificationIDs();
          var listDataDeleted = await SharedConfigName.getUserDeletedNotificationIDs();
          for(var element in listDataDeleted){
            if(!readAndDeletedNotificationIDs.contains(element))
              readAndDeletedNotificationIDs.add(element);
          }

          //String jsonText = jsonEncode(readAndDeletedNotificationIDs);

          int localCacheCount = readAndDeletedNotificationIDs.length;
          int totalCount = apiCount - localCacheCount;

          if(totalCount >0){
            countNotify.value = totalCount;
            isShowNotification.value = true;
          }else{
            countNotify.value = 0;
            isShowNotification.value = false;
          }
        }
      }
    }
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
    // var web = await webViewController.future;
    // web.loadUrl('https://www.africau.edu/images/default/sample.pdf');

    launch("https://gia.org.sg/images/pdf-files/MCF_Brochure.pdf");
  }
}