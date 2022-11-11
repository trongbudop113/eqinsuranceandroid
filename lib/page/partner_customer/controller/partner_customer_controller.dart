
import 'dart:io';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/hide_keyboard.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/partner_customer/models/login_hp_number_req.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class PartnerCustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerCustomerController());
  }

}

class PartnerCustomerController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();
  TextEditingController phoneText = TextEditingController();

  String countryCode = "65";

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onSubmitCheckPhone() async {
    isLoading.value = true;
    if(countryCode.isEmpty || phoneText.text.trim().isEmpty){
      showErrorMessage("Please enter your mobile number and country code.");
    }
    try{
      String hpNumber = phoneText.text.trim().toString();

      LoginHpNumberReq loginReq = LoginHpNumberReq();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sHpNumber = hpNumber;


      var response = await apiProvider.fetchData(ApiName.CheckHpNumber, loginReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          doWhenSuccess(data, hpNumber);
        }else{
          showErrorMessage("Cannot get AgentCode!");
        }
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      showErrorMessage("Cannot get AgentCode!");
    }
  }

  Future<void> doWhenSuccess(String response, String phone) async {
    var separateResult = response.split("\\|");
    final String _AgentCode = separateResult[0];
    final String URL = separateResult[1];

    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.PROMO){
      SharedConfigName.clearUserNotificationCache();
    }

    SharedConfigName.setAgentCode(_AgentCode);
    SharedConfigName.setPhone(phone);
    SharedConfigName.setRegisteredUserType("PROMO");

    Get.offAndToNamed(GetListPages.PARTNER, arguments: {'link', URL});

  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }
}