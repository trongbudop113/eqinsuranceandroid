import 'package:eqinsuranceandroid/get_pages.dart';
import 'package:eqinsuranceandroid/splash_page.dart';
import 'package:eqinsuranceandroid/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'EQ Insurance',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.dataTheme(),
        getPages: GetListPages.singleton.listPage(),
        home: SplashPage()
    );
  }
}
