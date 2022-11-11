
const ICON_PNG_PATH = "assets/images/";
const ICON_SVG_PATH = "assets/images/icon_svg/";

const String EXTENSION_PNG = ".png";
const String EXTENSION_SVG = ".svg";

class ImageResource {

  /// SVG File Path
  static String ic_arrow_connect = getSvgSourcePath("arrow_right");
  static String ic_arrow_right = getSvgSourcePath("ic_arrow_right");

  /// PNG File Path
  static String ic_approve_button = getPngSourcePath('approve_button');
  static String ic_back = getPngSourcePath("back");
  static String arrow_back_notification = getPngSourcePath('arrow_back_notification');
  static String bg = getPngSourcePath('bg');
  static String ic_call = getPngSourcePath('call');
  static String ic_close = getPngSourcePath('close_icon');
  static String ic_complete_step_3 = getPngSourcePath('complete_step_3_icon');
  static String ic_complete = getPngSourcePath('complete_icon');
  static String ic_warning_yellow = getPngSourcePath('ex_yellow');
  static String ic_warning = getPngSourcePath('ex');
  static String ic_exit = getPngSourcePath('exit');
  static String home = getPngSourcePath('home');
  static String home2 = getPngSourcePath('home2');
  static String ic_launcher = getPngSourcePath('ic_launcher');
  static String info_icon = getPngSourcePath('info_icon');
  static String key = getPngSourcePath('key');
  static String location = getPngSourcePath('location');
  static String lock = getPngSourcePath('lock');
  static String logo0 = getPngSourcePath('logo0');
  static String logo1 = getPngSourcePath('logo1');
  static String logo2 = getPngSourcePath('logo2');
  static String message = getPngSourcePath('message');
  static String ic_notifications = getPngSourcePath('notifications');
  static String popupx = getPngSourcePath('popupx');
  static String read_notification = getPngSourcePath('read_notification');
  static String sample_notification_details = getPngSourcePath('sample_notification_details');
  static String ic_settings = getPngSourcePath('settings');
  static String ic_settings_big = getPngSourcePath('settings_big');
  static String ic_trash = getPngSourcePath('trash');
  static String unread_notification = getPngSourcePath('unread_notification');
  static String user = getPngSourcePath('user');
}

String getPngSourcePath(String name) => ICON_PNG_PATH + name + EXTENSION_PNG;
String getSvgSourcePath(String name) => ICON_SVG_PATH + name + EXTENSION_SVG;