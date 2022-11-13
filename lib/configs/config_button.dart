import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:get/get.dart';

class ConfigButton{

  static final ConfigButton singleton = ConfigButton._internal();

  factory ConfigButton() {
    return singleton;
  }

  ConfigButton._internal();

  final RxBool isPublicUser = true.obs;
  final RxBool isPartner = true.obs;
  final RxBool isPartnerCustomer = true.obs;

  final RxInt isPublicUserType = 0.obs;
  final RxInt isPartnerType = 0.obs;
  final RxInt isPartnerCustomerType = 0.obs;

  Future<void> showHideButton() async {
    String currentUserType = await SharedConfigName.getCurrentUserType();
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
}