import 'package:eqinsuranceandroid/page/athentication/controller/authentication_controller.dart';
import 'package:eqinsuranceandroid/page/athentication/ui/authentication_page.dart';
import 'package:eqinsuranceandroid/page/change_sc/controller/change_sc_controller.dart';
import 'package:eqinsuranceandroid/page/change_sc/ui/change_sc_page.dart';
import 'package:eqinsuranceandroid/page/contact_us/controller/contact_us_controller.dart';
import 'package:eqinsuranceandroid/page/contact_us/ui/contact_us_page.dart';
import 'package:eqinsuranceandroid/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsuranceandroid/page/forget_sc/ui/forget_sc_page.dart';
import 'package:eqinsuranceandroid/page/home/controller/home_controller.dart';
import 'package:eqinsuranceandroid/page/home/ui/home_page.dart';
import 'package:eqinsuranceandroid/page/input_code/controller/input_code_controller.dart';
import 'package:eqinsuranceandroid/page/input_code/ui/input_code_page.dart';
import 'package:eqinsuranceandroid/page/login/controller/login_controller.dart';
import 'package:eqinsuranceandroid/page/login/ui/login_page.dart';
import 'package:eqinsuranceandroid/page/notification/controller/notification_controller.dart';
import 'package:eqinsuranceandroid/page/notification/controller/notification_detail_controller.dart';
import 'package:eqinsuranceandroid/page/notification/ui/notification_detail_page.dart';
import 'package:eqinsuranceandroid/page/notification/ui/notification_page.dart';
import 'package:eqinsuranceandroid/page/partner/controller/partner_controller.dart';
import 'package:eqinsuranceandroid/page/partner/ui/partner_page.dart';
import 'package:eqinsuranceandroid/page/partner_customer/controller/partner_customer_controller.dart';
import 'package:eqinsuranceandroid/page/partner_customer/ui/partner_customer_page.dart';
import 'package:eqinsuranceandroid/page/public_user/controller/public_user_controller.dart';
import 'package:eqinsuranceandroid/page/public_user/ui/public_user_page.dart';
import 'package:eqinsuranceandroid/page/register/controller/register_controller.dart';
import 'package:eqinsuranceandroid/page/register/ui/register_page.dart';
import 'package:eqinsuranceandroid/page/settings/controller/settings_controller.dart';
import 'package:eqinsuranceandroid/page/settings/ui/settings_page.dart';
import 'package:eqinsuranceandroid/page/term_and_privacy/controller/term_controller.dart';
import 'package:eqinsuranceandroid/page/webview/controller/webview_controller.dart';
import 'package:eqinsuranceandroid/page/webview/ui/webview_page.dart';
import 'package:get/get.dart';

import 'page/term_and_privacy/ui/term_page.dart';

class GetListPages{
  static final GetListPages singleton = GetListPages._internal();

  factory GetListPages() {
    return singleton;
  }

  GetListPages._internal();

  static String HOME = '/home';
  static String LOGIN = '/login';
  static String REGISTER = '/register';
  static String PARTNER = '/partner';
  static String CONTACT_US = '/contact_us';
  static String FORGET_SC = '/forget_sc';
  static String PUBLIC_USER = '/public_user';
  static String SETTINGS = '/settings';
  static String NOTIFICATION = '/notification';
  static String NOTIFICATION_DETAIL = '/notification_detail';
  static String CHANGE_SC = '/change_sc';
  static String INPUT_CODE = '/input_code';
  static String TERM_AND_PRIVACY = '/term_and_privacy';
  static String PARTNER_CUSTOMER = '/partner_customer';
  static String WEBVIEW = '/webview';
  static String AUTHENTICATION = '/authen';

  List<GetPage> listPage(){
    return [
      GetPage(
        name: HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
      ),
      GetPage(
        name: PARTNER,
        page: () => PartnerPage(),
        binding: PartnerBinding(),
      ),
      GetPage(
        name: CONTACT_US,
        page: () => ContactUsPage(),
        binding: ContactUsBinding(),
      ),
      GetPage(
        name: FORGET_SC,
        page: () => ForgetSCPage(),
        binding: ForgetSCBinding(),
      ),
      GetPage(
        name: PUBLIC_USER,
        page: () => PublicUserPage(),
        binding: PublicUserBinding(),
      ),
      GetPage(
        name: SETTINGS,
        page: () => SettingsPage(),
        binding: SettingsBinding(),
      ),
      GetPage(
        name: NOTIFICATION,
        page: () => NotificationPage(),
        binding: NotificationBinding(),
      ),
      GetPage(
        name: CHANGE_SC,
        page: () => ChangeSCPage(),
        binding: ChangeSCBinding(),
      ),
      GetPage(
        name: INPUT_CODE,
        page: () => InputCodePage(),
        binding: InputCodeBinding(),
      ),
      GetPage(
        name: NOTIFICATION_DETAIL,
        page: () => NotificationDetailPage(),
        binding: NotificationDetailBinding(),
      ),
      GetPage(
        name: TERM_AND_PRIVACY,
        page: () => TermPage(),
        binding: TermBinding(),
      ),
      GetPage(
        name: PARTNER_CUSTOMER,
        page: () => PartnerCustomerPage(),
        binding: PartnerCustomerBinding(),
      ),
      GetPage(
        name: WEBVIEW,
        page: () => WebViewPage(),
        binding: WebViewAppBinding(),
      ),
      GetPage(
        name: AUTHENTICATION,
        page: () => AuthenticationPage(),
        binding: AuthenticationBinding(),
      )
    ];
  }
}