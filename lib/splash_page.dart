import 'package:eqinsuranceandroid/configs/configs_data.dart';
import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/resource/image_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    initData();
    super.initState();
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
      body: Container(
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
    );
  }
}
