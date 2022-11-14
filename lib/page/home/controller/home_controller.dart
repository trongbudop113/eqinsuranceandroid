import 'dart:convert';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/home/models/GetPartnerCustomerReq.dart';
import 'package:eqinsuranceandroid/page/home/models/get_public_user_req.dart';
import 'package:eqinsuranceandroid/page/notification/models/notification_req.dart';
import 'package:eqinsuranceandroid/page/notification/models/notification_res.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/webview/model/get_contact_req.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:eqinsuranceandroid/widgets/dialog/home_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';
import 'package:aespack/aespack.dart';
import "package:pointycastle/digests/sha256.dart";
import 'package:crypto/crypto.dart' as CryptoPack;
import 'package:encrypt/encrypt.dart' as EncryptPack;
import 'dart:convert'  as ConvertPack;
import 'package:eqinsuranceandroid/network/aes_encryption_helper.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}

class HomeController extends GetxController{

  ApiProvider apiProvider = ApiProvider();
  final RxInt countNotify = 0.obs;
  final RxBool isShowNotification = false.obs;


  final RxBool isPublicUser = true.obs;
  final RxBool isPartner = true.obs;
  final RxBool isPartnerCustomer = true.obs;

  final RxInt isPublicUserType = 0.obs;
  final RxInt isPartnerType = 0.obs;
  final RxInt isPartnerCustomerType = 0.obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // or this

    showHideButton();
    refreshNotificationCount();
    openPopupNotification();
  }
  Future<void> testEncrypt() async {

  }

  Future<void> openPopupNotification() async {

    GetNotificationReq getNotificationReq = GetNotificationReq();
    getNotificationReq.sUserName = ConfigData.CONSUMER_KEY;
    getNotificationReq.sPassword = ConfigData.CONSUMER_SECRET;
    getNotificationReq.sType = "POPUP";
    getNotificationReq.sAgentCode = "";


    var response = await apiProvider.fetchData(ApiName.Notification, getNotificationReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String jsonString = root.children[2].children.first.toString();
      if(CheckError.isSuccess(jsonString)){
        if(jsonString != '' && jsonString != '0' && jsonString != 0){
          NotificationDataRes notificationDataRes = NotificationDataRes.fromJson(jsonDecode(jsonString));
          print("data....." + notificationDataRes.data!.length.toString());
          showHomeDialog(notificationDataRes.data![0]);
        }
      }
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
      Get.toNamed(GetListPages.CONTACT_US, arguments: {"link": link});
      isLoading.value = false;
    }else{
      isLoading.value = false;
      showErrorMessage("Can not load contact, please try again!");
    }
  }

  Future<void> getPublicUser() async {
    isLoading.value = true;
    GetPublicUserReq getPublicUserReq = GetPublicUserReq();
    getPublicUserReq.sUserName = ConfigData.CONSUMER_KEY;
    getPublicUserReq.sPassword = ConfigData.CONSUMER_SECRET;


    var response = await apiProvider.fetchData(ApiName.PublicLink, getPublicUserReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
    }
    isLoading.value = false;

    //Get.toNamed(GetListPages.AUTHENTICATION);
  }

  void goToPartnerCustomer(){
    if(SharedConfigName.getCurrentUserType == ConfigData.PROMO && SharedConfigName.getPhone != ''){
      showPartnerCustomerWebsite();
    }else{
      Get.toNamed(GetListPages.PARTNER_CUSTOMER);
    }
  }

  Future<void> goToPartnerPage() async {
    bool isSet = await SharedConfigName.isSetSC();
    if(isSet){
      Get.toNamed(GetListPages.INPUT_CODE);
    }else{
      Get.toNamed(GetListPages.REGISTER);
    }
  }

  Future<void> showPartnerCustomerWebsite() async {

    String vPhone = await SharedConfigName.getPhone();
    final String _MobileNo = "" + vPhone;

    GetPartnerCustomerReq getPartnerCustomerReq = GetPartnerCustomerReq();
    getPartnerCustomerReq.sUserName = ConfigData.CONSUMER_KEY;
    getPartnerCustomerReq.sPassword = ConfigData.CONSUMER_SECRET;
    getPartnerCustomerReq.sHpNumber = _MobileNo;


    var response = await apiProvider.fetchData(ApiName.CheckHpNumber, getPartnerCustomerReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String link = root.children[2].children.first.toString();
      if(CheckError.isSuccess(link)){
        var separateResult = response.split("\\|");
        //final String _AgentCode = separateResult[0];
        final String URL = separateResult[1];
        Get.toNamed(GetListPages.PARTNER, arguments: {"link": URL});
      }else{
        showErrorMessage("Cannot verify your mobile number!");
      }
    }
  }

  Future<void> refreshNotificationCount() async {
    isLoading.value = true;
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

    isLoading.value = false;
  }

  Future<void> showHideButton() async {
    String currentUserType = await SharedConfigName.getCurrentUserType();

    print("start encrypt.....");
    //testEncrypt();
    var text = 'mobileapi|cauugf6ORCafNuvfhBNxLg:APA91bGWk7S0Z1we_YrKm9Hc-FVG04230kodgyuQftmKL7mf4Stwt-hypkYzSzJH19emDxnKdEQN1IclTyCfGCWAN--5qasNLr3Dxski9IcEt3WXLmN2heDG1BWZboD_Vphq3Jx7f_TG';
    var key = '28103264-9141-4540-a55b-c4ec6596ee2dee2d'; //
    String test = AesHelper.encrypt(key, text);
    //var iv = '0000000000000000';
    //var iv = CryptoPack.sha256.convert(ConvertPack.utf8.encode(iv)).toString().substring(0, 16);         // Consider the first 16 bytes of all 64 bytes
    //var key = CryptoPack.sha256.convert(ConvertPack.utf8.encode(key)).toString().substring(0, 32);       // Consider the first 32 bytes of all 64 bytes
    //EncryptPack.IV ivObj = EncryptPack.IV.fromUtf8(iv);
    EncryptPack.Key keyObj = EncryptPack.Key.fromUtf8(key);
    //final encrypter = EncryptPack.Encrypter(EncryptPack.AES(keyObj, mode: EncryptPack.AESMode.cbc));        // Apply CBC mode
    //final decrypted = encrypter.encrypt(text,);
    //String firstBase64Decoding = new String.fromCharCodes(ConvertPack.base64.decode(payload));              // First Base64 decoding
    //var bytes1 = utf8.encode(key);         // data being hashed
    //var digest1 = sha256.convert(bytes1);
    //Future<String?> test = Aespack.encrypt(text, key, iv);
    //String? message = await test;
    print("encrpyted....." + test);
    print("end encrypt.....");

    if(currentUserType == ConfigData.PROMO){
      isPublicUser.value = false;
      isPartner.value = false;
      isPartnerCustomer.value = true;

      isPartnerCustomerType.value = 1;
    }else if(currentUserType == ConfigData.AGENT){

      isPartnerCustomer.value = false;
      isPublicUser.value = true;
      isPartner.value = true;

      isPublicUserType.value = 0;
      isPartnerType.value = 1;
    }else if(currentUserType == ConfigData.PUBLIC){
      isPublicUser.value = true;
      isPartner.value = true;
      isPartnerCustomer.value = true;

      isPublicUserType.value = 1;
      isPartnerType.value = 0;
      isPartnerCustomerType.value = 0;
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void showHomeDialog(NotificationRes data){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.7),
        context: Get.context!,
        builder: (_) => HomeDialog(data: data)
    );
  }


}