import 'dart:io';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/hide_keyboard.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/register/models/login_req.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class InputCodeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InputCodeController());
  }

}

class InputCodeController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();
  TextEditingController scText = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> onSubmitLoginAgentCode() async {

    String userID = await SharedConfigName.getUserID();
    String pin = scText.text.trim().toString();

    if(pin.isEmpty){
      showErrorMessage("Please enter Security Code");
    }else{
      Login1Req loginReq = Login1Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sPin = pin;

      loginReq.sManufacturer = null;
      loginReq.sModel = null;
      loginReq.sOsName = null;
      loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


      var response = await apiProvider.fetchData(ApiName.LoginWithSecurityCode, loginReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          doWhenLoginSuccess(data);
        }else{
          showErrorMessage("Cannot login. Security Code is wrong!");
        }
        //Get.toNamed(GetListPages.PUBLIC_USER, arguments: {"link": link});
      }
    }
  }

  void doWhenLoginSuccess(String data){
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"res" : data});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}