import 'dart:io';

import 'package:eqinsuranceandroid/configs/config_button.dart';
import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/hide_keyboard.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_name.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/register/controller/check_error.dart';
import 'package:eqinsuranceandroid/page/register/models/country_code_res.dart';
import 'package:eqinsuranceandroid/page/register/models/input_code_req.dart';
import 'package:eqinsuranceandroid/page/register/models/login_req.dart';
import 'package:eqinsuranceandroid/page/register/models/phone_number_req.dart';
import 'package:eqinsuranceandroid/page/register/models/user_account_req.dart';
import 'package:eqinsuranceandroid/page/register/models/verify_code_req.dart';
import 'package:eqinsuranceandroid/page/register/page/input_code_page.dart';
import 'package:eqinsuranceandroid/page/register/page/verify_code_page.dart';
import 'package:eqinsuranceandroid/page/register/page/verify_phone_page.dart';
import 'package:eqinsuranceandroid/page/register/page/verify_user_page.dart';
import 'package:eqinsuranceandroid/widgets/dialog/country_code_dialog.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }

}

class RegisterController extends GetxController with KeyboardHiderMixin{

  ApiProvider apiProvider = ApiProvider();

  final RxInt currentIndex = 0.obs;

  TextEditingController userIDText = TextEditingController();
  TextEditingController userPasswordText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();
  //TextEditingController pinCodeText = TextEditingController();
  TextEditingController scText = TextEditingController();
  TextEditingController confirmSCText = TextEditingController();

  List<int> listCountPage = List.generate(4, (index) => 0);

  RxString textLocationPhone = "".obs;
  RxString textCountryCodePhone = "".obs;

  String pinCodeText = '';

  RxList<CountryCode> listCountryCode = <CountryCode>[].obs;
  var listCountryCodeGen = CountryCodeRes.listCountryCode();

  final formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    initCountryCode();
    super.onInit();
  }

  void initCountryCode(){
    try{
      var countryCodeCurrent = listCountryCodeGen.where((element) => element.id == "65").first;
      countryCodeCurrent.isChecked.value = true;
      textLocationPhone.value = countryCodeCurrent.name ?? '';
      textCountryCodePhone.value = countryCodeCurrent.id ?? '';
      listCountryCode.value = listCountryCodeGen;
    }catch(e){
      textLocationPhone.value = 'Singapore';
      textCountryCodePhone.value = '65';
    }
  }

  void onSearchCountryCode(String value){
    try{
      listCountryCode.value = listCountryCodeGen;
      var listSearch = listCountryCode.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
      listCountryCode.value = listSearch;
    }catch(e){

    }
  }

  void onFocusPage(int i) {
    currentIndex.value = i;
  }

  void showLoading(){
    isLoading.value = true;
  }

  void hideLoading(){
    isLoading.value = false;
  }

  Future<void> onSubmitUserAccount() async {
    showLoading();
    try{
      if(userIDText.text.trim().isEmpty || userPasswordText.text.trim().isEmpty){
        showErrorMessage("Please enter User ID and Password");
      }else{
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
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage('User ID or Password is wrong!');
    }
  }

  Future<void> onSubmitVerifyPhoneNumber() async {
    showLoading();
    try{

      if(textCountryCodePhone.value.trim() != '' || phoneNumberText.text.trim() != ''){
        showErrorMessage("Please enter your mobile number and select country");
      }else{
        final String _MobileNo = textCountryCodePhone.value + phoneNumberText.text.trim();

        PhoneNumberReq phoneNumberReq = PhoneNumberReq();
        phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
        phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
        phoneNumberReq.sUserID = userID;
        phoneNumberReq.sMobileNo = _MobileNo;


        var response = await apiProvider.fetchData(ApiName.SendSMSWithOTP, phoneNumberReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifyPhoneSuccess(phoneNumberText.text.trim(), textCountryCodePhone.value);
          }else{
            showErrorMessage("Cannot send SMS to your mobile number!");
          }
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot send SMS to your mobile number!");
    }
  }

  Future<void> onSubmitVerifyCodeOTP() async {
    showLoading();
    try{
      if(pinCodeText != '' && pinCodeText.length == 6){
        final String _MobileNo = countryCode + phoneNumber;
        print("pinCode ...." + pinCodeText);

        VerifyCodeReq phoneNumberReq = VerifyCodeReq();
        phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
        phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
        phoneNumberReq.sUserID = userID;
        phoneNumberReq.sMobileNo = _MobileNo;
        phoneNumberReq.sOTP = pinCodeText;


        var response = await apiProvider.fetchData(ApiName.VerifyOTP, phoneNumberReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifyOTPSuccess(pinCodeText);
          }else{
            showErrorMessage("OTP is wrong!");
          }
        }
      }else{
        showErrorMessage("Please enter OTP");
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("OTP is wrong!");
    }
  }

  Future<void> onSubmitSCCode() async {
    showLoading();
    var sc = scText.text.trim().toString();
    var confirmSc = confirmSCText.text.trim().toString();

    try{
      if(sc.isEmpty || confirmSc.isEmpty){
        showErrorMessage("Please enter Security Code and Confirm Security Code.");
      }else if(sc.length != 6 || confirmSc.length != 6){
        showErrorMessage("Security Code must contain 6 digits.");
      }else if(!(sc == confirmSc)){
        showErrorMessage("Security Code does not match the Confirm Security Code.");
      }else{
        final String _MobileNo = countryCode + phoneNumber;

        InputCodeReq inputCodeReq = InputCodeReq();
        inputCodeReq.sUserName = ConfigData.CONSUMER_KEY;
        inputCodeReq.sPassword = ConfigData.CONSUMER_SECRET;
        inputCodeReq.sUserID = userID;
        inputCodeReq.sMobileNo = _MobileNo;
        inputCodeReq.sOTP = otp;
        inputCodeReq.sPin = sc;

        inputCodeReq.sManufacturer = null;
        inputCodeReq.sModel = null;
        inputCodeReq.sOsName = null;
        inputCodeReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


        var response = await apiProvider.fetchData(ApiName.InsertRecord, inputCodeReq);
        if(response != null){
          var root = XmlDocument.parse(response);
          print("data....." + root.children[2].children.first.toString());
          String data = root.children[2].children.first.toString();

          if(CheckError.isSuccess(data)){
            doWhenVerifySCSuccess(sc);
          }else{
            showErrorMessage("Invalid Security Code!");
          }
        }
      }
    }catch(e){
      hideLoading();
      showErrorMessage("Invalid Security Code!");
    }
  }

  Future<void> onSubmitLogin() async {
    try{
      Login1Req loginReq = Login1Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sPin = scCode;

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
          doWhenSuccessLoginWithSecurityCode();
        }else{
          showErrorMessage("Cannot login. Please contact website admin!");
        }
      }
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot login. Please contact website admin!");
    }
  }

  Future<void> onSubmitLoginAgentCode() async {
    try{
      Login2Req loginReq = Login2Req();
      loginReq.sUserName = ConfigData.CONSUMER_KEY;
      loginReq.sPassword = ConfigData.CONSUMER_SECRET;
      loginReq.sUserID = userID;
      loginReq.sUserPass = userPassword;

      loginReq.sManufacturer = null;
      loginReq.sModel = null;
      loginReq.sOsName = null;
      loginReq.sOsVersion = Platform.isAndroid ? 'android' : 'ios';


      var response = await apiProvider.fetchData(ApiName.GetAgentCode, loginReq);
      if(response != null){
        var root = XmlDocument.parse(response);
        print("data....." + root.children[2].children.first.toString());
        String data = root.children[2].children.first.toString();

        if(CheckError.isSuccess(data)){
          await ConfigButton.singleton.showHideButton();
          doWhenLoginSuccess(data);
        }else{
          showErrorMessage("Cannot get AgentCode!");
        }
      }
      hideLoading();
    }catch(e){
      hideLoading();
      showErrorMessage("Cannot get AgentCode!");
    }
  }

  Future<void> onSubmitResendCode() async {

    final String _MobileNo = textCountryCodePhone.value + phoneNumberText.text.trim();

    PhoneNumberReq phoneNumberReq = PhoneNumberReq();
    phoneNumberReq.sUserName = ConfigData.CONSUMER_KEY;
    phoneNumberReq.sPassword = ConfigData.CONSUMER_SECRET;
    phoneNumberReq.sUserID = userID;
    phoneNumberReq.sMobileNo = _MobileNo;


    var response = await apiProvider.fetchData(ApiName.SendSMSWithOTP, phoneNumberReq);
    if(response != null){
      var root = XmlDocument.parse(response);
      print("data....." + root.children[2].children.first.toString());
      String data = root.children[2].children.first.toString();

      if(CheckError.isSuccess(data)){
        showErrorMessage("New OTP has been sent to you.");
      }else{
        showErrorMessage("Cannot send SMS to your mobile number!");
      }

    }
  }

  String userID = '';
  String userPassword = '';
  void doWhenVerifyUserSuccess(String _UserID, String _UserPass){
    SharedConfigName.setUserID(_UserID);
    SharedConfigName.setUserPass(_UserPass);

    userIDText.clear();
    userPasswordText.clear();
    userID = _UserID;
    userPassword = _UserPass;
    onFocusPage(1);
  }

  String phoneNumber = '';
  String countryCode = '';
  void doWhenVerifyPhoneSuccess(String phone, String code){
    phoneNumber = phone;
    countryCode = code;

    phoneNumberText.clear();
    listCountryCodeGen = CountryCodeRes.listCountryCode();
    initCountryCode();
    //missing

    onFocusPage(2);
  }

  String otp = "";
  void doWhenVerifyOTPSuccess(String _otp){
    this.otp = otp;

    pinCodeText = '';
    onFocusPage(3);
  }

  String scCode = '';
  void doWhenVerifySCSuccess(String scCode){
    this.scCode = scCode;
    onSubmitLogin();
  }

  Future<void> doWhenSuccessLoginWithSecurityCode() async {
    String currentUserType = await SharedConfigName.getCurrentUserType();
    if(currentUserType != ConfigData.AGENT){
      await SharedConfigName.clearUserNotificationCache();
    }

    SharedConfigName.setSC(scCode);
    SharedConfigName.setRegisteredUserType("AGENT");
    SharedConfigName.setPhone(countryCode + phoneNumber);
    onSubmitLoginAgentCode();
  }

  void doWhenLoginSuccess(String data){
    SharedConfigName.setAgentCode(data);
    Get.offAndToNamed(GetListPages.PARTNER, arguments: {"res" : data});
  }

  void showErrorMessage(String message){
    showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
  }

  void showDialogSelectCountryCode(){
    showDialog(
      context: Get.context!,
      builder: (_) => CountryCodeDialog(controller: this)
    );
  }

  void onChangeSearchCountry(int index){
    try{
      CountryCode countryCode = listCountryCodeGen.where((e) => e.id == textCountryCodePhone.value).first;
      countryCode.isChecked.value = false;

      CountryCode countryCodeNew = listCountryCodeGen[index];
      countryCodeNew.isChecked.value = true;
      textCountryCodePhone.value = countryCodeNew.id ?? '';
      textLocationPhone.value = countryCodeNew.name ?? '';

      listCountryCode.value = listCountryCodeGen;
    }catch(e){

    }
  }

  Widget getWidgetContent(){
    if(currentIndex.value == 0){
      return VerifyUserPage(controller: this);
    }else if(currentIndex.value == 1){
      return VerifyPhonePage(controller: this);
    }else if(currentIndex.value == 2){
      return VerifyCodePage(controller: this);
    }else if(currentIndex.value == 3){
      return InputCodePage(controller:  this);
    }else{
      return Container();
    }
  }

  void onBackPress(){
    pinCodeText = "";
    phoneNumberText.clear();
    userPasswordText.clear();
    userIDText.clear();
    scText.clear();
    confirmSCText.clear();
    initCountryCode();
    listCountryCodeGen = CountryCodeRes.listCountryCode();
    if(currentIndex.value == 3){
      currentIndex.value = 2;
    }else if(currentIndex.value == 2){
      currentIndex.value = 1;
    }else if(currentIndex.value == 1){
      currentIndex.value = 0;
    }else{
      Get.back();
    }
  }

}