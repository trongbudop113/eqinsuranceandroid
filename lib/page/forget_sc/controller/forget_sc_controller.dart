import 'dart:io';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/hide_keyboard.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/forget_sc/page/new_sc_page.dart';
import 'package:eqinsuranceandroid/page/forget_sc/page/verify_user_page.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/register/models/login_req.dart';
import 'package:eqinsuranceandroid/page/register/models/user_account_req.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class ForgetSCBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetSCController());
  }

}

class ForgetSCController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();

  TextEditingController userIDText = TextEditingController();
  TextEditingController userPasswordText = TextEditingController();
  TextEditingController scText = TextEditingController();
  TextEditingController confirmSCText = TextEditingController();

  final RxInt currentIndex = 0.obs;

  final RxBool isLoading = false.obs;

  void onFocusPage(int i) {
    currentIndex.value = i;
  }

  Future<void> onSubmitUserAccount() async {
    isLoading.value = true;
    try{
      UserAccountReq userAccountReq = UserAccountReq();
      userAccountReq.sUserName = ConfigData.CONSUMER_KEY;
      userAccountReq.sPassword = ConfigData.CONSUMER_SECRET;
      userAccountReq.sUserID = userIDText.text.trim();
      userAccountReq.sUserPass = userPasswordText.text.trim();


      var response = await apiProvider.fetchData(ApiName.IsValidateID, userAccountReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          doWhenVerifyUserSuccess(userIDText.text.trim(), userPasswordText.text.trim());
        }else{
          showErrorMessage('User ID or Password is wrong!');
        }
      }
      isLoading.value = false;
    }catch(e){
      showErrorMessage("Error, Please try again!");
      isLoading.value = false;
    }
  }

  Future<void> onSubmitSCCode() async {
    isLoading.value = true;
    try{
      String userID = await SharedConfigName.getUserID();
      var sc = scText.text.trim().toString();
      var confirmSc = confirmSCText.text.trim().toString();

      if(sc.isEmpty || confirmSc.isEmpty){
        showErrorMessage("Please enter Security Code and Confirm Security Code.");
      }else if(sc.length != 6 || confirmSc.length!=6){
        showErrorMessage("Security Code must contain 6 digits.");
      }else if(!(sc == confirmSc)){
        showErrorMessage("Security Code does not match the Confirm Security Code.");
      }else{

        Login1Req inputCodeReq = Login1Req();
        inputCodeReq.sUserName = ConfigData.CONSUMER_KEY;
        inputCodeReq.sPassword = ConfigData.CONSUMER_SECRET;
        inputCodeReq.sUserID = userID;
        inputCodeReq.sPin = sc;

        inputCodeReq.sManufacturer = null;
        inputCodeReq.sModel = null;
        inputCodeReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


        var response = await apiProvider.fetchData(ApiName.ResetPin, inputCodeReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            onSubmitLogin(sc);
          }else{
            showErrorMessage("Cannot reset Security Code. Please contact website admin!");
          }
        }
      }
    }catch(e){
      showErrorMessage("Error, Please try again!");
      isLoading.value = false;
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
          showSuccessMessage(data);
        }else{
          showErrorMessage("Cannot login. Please contact website admin!");
        }
      }
      isLoading.value = false;
    }catch(e){
      showErrorMessage("Error, Please try again!");
      isLoading.value = false;
    }
  }

  void doWhenVerifyUserSuccess(String _UserID, String _UserPass){
    userIDText.clear();
    userPasswordText.clear();
    onFocusPage(1);
  }

  void doWhenSuccessLoginWithSecurityCode(String res){
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"link" : res});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  Future<void> showSuccessMessage(String res) async {
    await showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: "Security Code Successfully created"),
    );
    doWhenSuccessLoginWithSecurityCode(res);
  }


  Widget getWidgetContent(){
    if(currentIndex.value == 0){
      return VerifyUserPage(controller: this);
    }else if(currentIndex.value == 1){
      return NewSCPage(controller: this);
    }else{
      return Container();
    }
  }

  void onBackPress(){
    if(currentIndex.value == 1){
      currentIndex.value = 0;
    }else{
      Get.back();
    }
  }

}