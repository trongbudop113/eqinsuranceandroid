import 'dart:convert';
import 'dart:io';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/change_sc/models/change_sc_req.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/register/models/login_req.dart';
import 'package:eqinsuranceandroid/page/webview/models/notification_detail_req.dart';
import 'package:eqinsuranceandroid/page/webview/models/update_device_req.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:eqinsuranceandroid/widgets/dialog/portal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class AuthenticationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }

}

class AuthenticationController extends GetxController{

  final RxBool isShowView = true.obs;
  ApiProvider apiProvider = ApiProvider();

  final RxString textAuthenticated = "Authenticated".obs;
  final RxString imageApproved = ImageResource.ic_complete.obs;

  String AuthenticateKey = "";

  String fireBaseKey = "", requestTokenUrl = "", completeTokenUrl = "", apiUsername = "", apiKey = "";

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    String userId =  await SharedConfigName.getUserID();
    if (userId.isNotEmpty)
      requestToGetAPIInfo();
  }

  Future<void> requestToGetAPIInfo() async {
    isLoading.value = true;
    try{
      GetAPIInfoReq getAPIInfoReq = GetAPIInfoReq();
      getAPIInfoReq.sUserName = ConfigData.CONSUMER_KEY;
      getAPIInfoReq.sPassword = ConfigData.CONSUMER_SECRET;
      getAPIInfoReq.sEnvironment = ConfigData.EVR_CODE;

      var response = await apiProvider.fetchData(ApiName.GetNotificationDetails, getAPIInfoReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          var temValues = data.split("\|");

          fireBaseKey = temValues[0];
          requestTokenUrl = temValues[1];
          completeTokenUrl = temValues[2];
          apiUsername = temValues[3];
          apiKey = temValues[4];
          getInstanceToken();

          print("data....." + requestTokenUrl + "...." + fireBaseKey);
        }else{
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  void getInstanceToken(){
    // String token = task.getResult().getToken();
    // byte[] IV = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    // final String requestKey = base64Encode(Encryption.encrypt((apiUsername + "|" + token).getBytes(), apiKey, IV), Base64.DEFAULT);
    // requestToUpdateDeviceAPI(requestKey);
  }

  Future<void> requestToUpdateDeviceAPI(String requestKey) async {
    isLoading.value = true;
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
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        try{
          if(CheckError.isSuccess(data)){
            var jsonObject = jsonDecode(data);
            showHideApproveArea(true);
          }else{
            showHideApproveArea(false);
            imageApproved.value = ImageResource.ic_warning_yellow;
            textAuthenticated.value = "Please try again.";
          }
        }catch(e){
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  Future<void> requestToApprove() async {
    isLoading.value = true;
    try{
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));

      ApproveReq approveReq = ApproveReq();
      approveReq.RequestToken = AuthenticateKey;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/ApproveToken", approveReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){

        }else{
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  Future<void> requestToReject() async {
    isLoading.value = true;
    try{
      String reQuestUrl = requestTokenUrl.substring(0, requestTokenUrl.indexOf("/RequestToken"));

      ApproveReq approveReq = ApproveReq();
      approveReq.RequestToken = AuthenticateKey;

      var response = await apiProvider.fetchDataUpdateDevice(reQuestUrl + "/RejectToken", approveReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          if(data == '0'){
            
          }else{
            showErrorMessage('"Reject failed. Please try again"');
          }
        }else{
          showHideApproveArea(false);
          imageApproved.value = ImageResource.ic_warning_yellow;
          textAuthenticated.value = "Please try again.";
        }
      }
      isLoading.value = false;

    }catch(e){
      isLoading.value = false;
      showHideApproveArea(false);
      imageApproved.value = ImageResource.ic_warning_yellow;
      textAuthenticated.value = "Please try again.";
    }
  }

  void showHideApproveArea(bool show) {
    if (show){
      isShowView.value = true;
    } else {
      isShowView.value = false;
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void showAuthenticationPortal(){
    showDialog(
      context: Get.context!,
      builder: (_) => PortalDialog(authenticationController: this),
    );
  }

}