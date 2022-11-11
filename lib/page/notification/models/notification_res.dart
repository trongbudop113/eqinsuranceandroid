import 'package:get/get.dart';

class NotificationDataRes {
  List<NotificationRes>? data;

  NotificationDataRes({this.data});

  NotificationDataRes.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      data = <NotificationRes>[];
      json['DATA'].forEach((v) {
        data!.add(new NotificationRes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['DATA'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationRes {
  String? iD;
  String? subject;
  String? message;
  String? messageDate;
  String? picPath;

  RxBool isCheck = false.obs;
  RxBool isRead= false.obs;

  NotificationRes({this.iD, this.subject, this.message, this.messageDate, this.picPath});

  NotificationRes.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    subject = json['Subject'];
    message = json['Message'];
    messageDate = json['MessageDate'];
    picPath = json['PicPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Subject'] = this.subject;
    data['Message'] = this.message;
    data['MessageDate'] = this.messageDate;
    data['PicPath'] = this.picPath;
    return data;
  }
}