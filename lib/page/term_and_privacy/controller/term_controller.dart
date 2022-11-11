import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TermController());
  }

}

class TermController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> setAgreeTerm() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(ConfigData.IS_AGREE_TERM, true);
    Get.offAndToNamed(GetListPages.HOME);
  }

  //https://www.eqinsurance.com.sg/CorporatePolicies/privacy-policy
  void openTermAndPolicyPage(){
    Get.toNamed(GetListPages.WEBVIEW, arguments:[{"link": 'https://www.eqinsurance.com.sg/CorporatePolicies/privacy-policy'},  {"page": 'Privacy Policy'}]);
  }

}