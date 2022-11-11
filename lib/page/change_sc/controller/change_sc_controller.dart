import 'dart:io';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/hide_keyboard.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/change_sc/models/change_sc_req.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/register/models/login_req.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class ChangeSCBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeSCController());
  }

}

class ChangeSCController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();

  TextEditingController currentScText = TextEditingController();
  TextEditingController newScText = TextEditingController();
  TextEditingController confirmScText = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> onSubmitChangeSC() async {
    isLoading.value = true;
    try{
      String userID = await SharedConfigName.getUserID();

      var currentSc = currentScText.text.trim().toString();
      var newSc = newScText.text.trim().toString();
      var confirmSc = confirmScText.text.trim().toString();

      if(currentSc.isEmpty || newSc.isEmpty || confirmSc.isEmpty){
        showErrorMessage("Please enter all security codes.");
      }else if(currentSc.length != 6 || newSc.length != 6 || confirmSc.length != 6){
        showErrorMessage("Security Code must contain 6 digits.");
      }else if(newSc != confirmSc){
        showErrorMessage("New Security Code does not match the Confirm Security Code.");
      }else{
        ChangeSCReq changeSCReq = ChangeSCReq();
        changeSCReq.sUserName = ConfigData.CONSUMER_KEY;
        changeSCReq.sPassword = ConfigData.CONSUMER_SECRET;
        changeSCReq.sUserID = userID;
        changeSCReq.sOldPin = currentSc;
        changeSCReq.sNewPin = newSc;

        changeSCReq.sManufacturer = null;
        changeSCReq.sModel = null;
        changeSCReq.sOsName = null;
        changeSCReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';

        var response = await apiProvider.fetchData(ApiName.ChangePin, changeSCReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            onSubmitLogin(newSc);
          }else{
            showErrorMessage("Old Security Code is wrong!");
          }
        }
      }
    }catch(e){
      isLoading.value = false;
      showErrorMessage("Error, Please try again!");
    }

  }

  Future<void> onSubmitLogin(String sc) async {

    try{
      String userID = await SharedConfigName.getUserID();

      Login1Req loginReq = Login1Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sPin = sc;

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
          Get.offAndToNamed(GetListPages.PARTNER, arguments: {"link" : data});
        }else{
          showErrorMessage("Cannot login. Please contact website admin!");
        }
        isLoading.value = false;
      }
    }catch(e){
      isLoading.value = false;
      showErrorMessage("Error, Please try again!");
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

}