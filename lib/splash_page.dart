import 'dart:io';

import 'package:eqinsuranceandroid/configs/check_network.dart';
import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/configs/shared_config_name.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/network/api_provider.dart';
import 'package:eqinsuranceandroid/page/loading/loading_page.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:eqinsuranceandroid/widgets/dialog/error_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  ApiProvider apiProvider = ApiProvider();

  final RxBool isLoading = true.obs;

  @override
  void initState() {
    initGoToPage();
    super.initState();
  }

  Future<void> initGoToPage() async {
    isLoading.value = true;
    if(await CheckConnect.hasNetwork()){
      String? token = await initFirebase();
      print("token....."+ token);
      if(token.isNotEmpty){
        await SharedConfigName.setTokenFirebase(token);
      }
      isLoading.value = false;
      initData();
    }else{
      isLoading.value = false;
      showErrorMessage("Network Error, Please try again!");
    }
  }

  Future<void> showErrorMessage(String message) async {
    await showDialog(
      context: Get.context!,
      builder: (_) => ErrorDialog(message: message),
    );
    exit(0);
  }

  late final FirebaseMessaging _firebaseMessaging;
  Future<String> initFirebase() async {
    _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupFlutterNotifications();
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    String? token = await _firebaseMessaging.getToken();
    if((token ?? '').isNotEmpty){
      return token!;
    }
    return "";
  }


  Future<void> initData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    bool isAgree = sharedPreferences.getBool(ConfigData.IS_AGREE_TERM) ?? false;
    if(isAgree){
      Get.offAndToNamed(GetListPages.HOME);
    }else{
      Get.offAndToNamed(GetListPages.TERM_AND_PRIVACY);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(ImageResource.bg),
                    fit: BoxFit.fill
                )
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: 70),
                Image.asset(ImageResource.logo1, width: Get.width * 0.5),
              ],
            ),
          ),
          Obx(() => LoadingPage(isLoading: isLoading.value))
        ],
      ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}
