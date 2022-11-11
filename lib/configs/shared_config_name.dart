import 'dart:convert';
import 'dart:core';

import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedConfigName{
  static const String sc = "sc";
  static const String UserID = "_UserID";
  static const String UserPass = "_UserPass";
  static const String AgentCode = "_AgentCode";
  static const String phone= "phone";
  static const String userType = "userType";
  static const String userNotificationReadIDs = "userNotificationReadIDs";
  static const String userNotificationDeletedIDs = "userNotificationDeletedIDs";
  static const String popupID = "popupID";

  static const String NotificationsPerPage = "NotificationsPerPage";


  static Future<void> logoutUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(sc);
    sharedPreferences.remove(UserID);
    sharedPreferences.remove(UserPass);
    sharedPreferences.remove(AgentCode);
    sharedPreferences.remove(phone);
    sharedPreferences.remove(userType);
    sharedPreferences.remove(userNotificationReadIDs);
    sharedPreferences.remove(userNotificationDeletedIDs);
    sharedPreferences.remove(popupID);
    sharedPreferences.remove(NotificationsPerPage);
  }


  static Future<void> setNotificationsPerPage(int number) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(NotificationsPerPage, number);
  }

  static Future<String> getCurrentUserType() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String data =  sharedPreferences.getString(userType) ?? '';
    if(data != ''){
      return userType;
    }
    return ConfigData.PUBLIC;
  }

  static Future<void> clearUserNotificationCache() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(userNotificationReadIDs);
    sharedPreferences.remove(userNotificationDeletedIDs);
  }

  static Future<String> getPhone() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(phone) ?? '';
  }

  static Future<bool> isSetSC() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String data =  sharedPreferences.getString(sc) ?? '';
    if(data != ''){
      return true;
    }
    return false;
  }

  static Future<void> setUserID(String sc) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(UserID, sc);
  }
  static Future<String> getUserID() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(UserID) ?? '';
  }

  //v2
  static Future<void> setUserPass(String userPass) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(UserPass, userPass);
  }

  static Future<String> getUserPass() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(UserPass) ?? '';
  }

  static Future<void> setSC( String scCode) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(sc, scCode);
  }

  static Future<String> getSC() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sc) ?? '';
  }

  static Future<void> setRegisteredUserType(String userType) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userType, userType);
  }

  static Future<String> getRegisteredUserType() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userType) ?? '';
  }

  static Future<void> setPhone(String phoneNumber) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(phone, phoneNumber);
  }

  static Future<void> setAgentCode(String agentCode) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AgentCode, agentCode);
  }

  static Future<String> getAgentCode() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String _AgentCode = sharedPreferences.getString(AgentCode) ?? '';
    if(_AgentCode != ''){
      return _AgentCode;
    }else{
      return "";
    }
  }

  static Future<List<String>> getUserReadNotificationIDs() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String userNotificationReadIDsJSONString =  sharedPreferences.getString(userNotificationReadIDs) ?? '';
    if(userNotificationReadIDsJSONString != ''){

      List<String> userNotificationReadIDs = List<String>.from(jsonDecode(userNotificationReadIDsJSONString));
      return userNotificationReadIDs;
    }
    return [];
  }

  static Future<List<String>> getUserDeletedNotificationIDs() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String userNotificationDeletedIDsJSONString =  sharedPreferences.getString(userNotificationDeletedIDs) ?? '';
    if(userNotificationDeletedIDsJSONString != ""){

      List<String> userNotificationDeletedIDs = List<String>.from(jsonDecode(userNotificationDeletedIDsJSONString));
      return userNotificationDeletedIDs;
    }
    return [];
  }

  static Future<int> getNotificationsPerPage() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    int notificationsPerPage = sharedPreferences.getInt(NotificationsPerPage) ?? 0;
    if(notificationsPerPage != 0){
      return notificationsPerPage;
    }else{
      return 10;
    }
  }

  static Future<void> addUserReadNotificationID(String ID) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> userNotificationReadIDList = await getUserReadNotificationIDs();
    if(!userNotificationReadIDList.contains(ID)){
      userNotificationReadIDList.add(ID);

      String jsonText = jsonEncode(userNotificationReadIDList);
      sharedPreferences.setString(userNotificationReadIDs, jsonText);
    }
  }

  static Future<void> addUserDeletedNotificationID(List<String> userNotificationDeletedIDList) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    List<String> userNotificationDeletedIDsToSave = await getUserDeletedNotificationIDs();
    userNotificationDeletedIDsToSave.addAll(userNotificationDeletedIDList);

    String jsonText = jsonEncode(userNotificationDeletedIDsToSave);
    sharedPreferences.setString(userNotificationDeletedIDs, jsonText);


  }
}