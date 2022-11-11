import 'package:eqinsuranceandroid/page/notification/models/notification_res.dart';
import 'package:eqinsuranceandroid/widgets/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationDetailController());
  }

}

class NotificationDetailController extends GetxController{

  final Rx<NotificationRes> notificationRes = NotificationRes().obs;
  final RxString pageTitle = ''.obs;


  @override
  void onInit() {
    getArgumentData();
    super.onInit();
  }

  void getArgumentData(){
    NotificationRes data = Get.arguments['data'];
    notificationRes.value = data;
    pageTitle.value = data.subject ?? '';
  }

  Future<void> onDeleteNotification(BuildContext context) async {
    bool isOk = await showDialog(
      context: context,
      builder: (_) => ConfirmDialog(message: "Delete Notification?"),
    );

    if(isOk){
      Get.back(result: true);
    }
  }

}