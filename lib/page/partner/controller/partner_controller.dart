import 'dart:async';
import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/notification/models/notification_req.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/webview/model/get_contact_req.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class PartnerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerController());
  }

}

class PartnerController extends GetxController{
  final Completer<WebViewController> webViewController = Completer<WebViewController>();

  ApiProvider apiProvider = ApiProvider();

  String url = "";

  final RxInt countNotify = 0.obs;
  final RxBool isShowNotification = false.obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getIntentParam();
    refreshNotificationCount();
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
      Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
    }
    isLoading.value = false;
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

  bool isContact = false;

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