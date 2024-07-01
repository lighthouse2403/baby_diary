import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baby_diary/_gen/assets.gen.dart';
import 'package:baby_diary/bottom_tab_bar/bottom_tab_bar_item.dart';
import 'package:baby_diary/common/constants/models/homeItem.dart';

class Constants {
  static List<BaseItem> homeItems = [
    BaseItem(
        Assets.icons.chat.svg(
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(Constants.pinkTextColor(), BlendMode.srcIn)
        ),
        'Lịch'
    ),
    BaseItem(
        Assets.icons.weight.svg(
            width: 30,
            height: 30,
            colorFilter: ColorFilter.mode(Constants.pinkTextColor(), BlendMode.srcIn)
        ),
        'Chỉ số thai nhi'
    ),
    BaseItem(Assets.icons.music.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Âm nhạc'),
    BaseItem(Assets.icons.babyKick.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Em bé đạp'),
    BaseItem(Assets.icons.clinic.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Danh sách bác sỹ'),
    BaseItem(Assets.icons.weight.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Cân nặng bé yêu'),
    BaseItem(Assets.icons.weight.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Đồ sơ sinh'),
    BaseItem(Assets.icons.babyName.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Tên hay'),
    BaseItem(Assets.icons.injection.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Địa chỉ phòng tiêm'),
    BaseItem(Assets.icons.driverLicense.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Ứng dụng học lái xe'),
    BaseItem(Assets.icons.mobileApp.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)),
        'Ứng dụng chu kỳ kinh'),
    BaseItem(Assets.icons.group.svg(width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
            Constants.pinkTextColor(), BlendMode.srcIn)), 'Nhóm thảo luận'),
  ];

  static List<BottomTabBarItem> bottomTabBarItems = [
    BottomTabBarItem(Assets.icons.chat, 'Diễn đàn'),
    BottomTabBarItem(Assets.icons.chat, 'Diễn đàn'),
  ];

  /// Color
  static Color mainColor() => const Color(0xFF47AC66);
  static Color pinkTextColor() => const Color(0xFFFF66A3);
  static Color primaryTextColor() => const Color(0xFF0B0B1E);
  static Color secondaryTextColor() => const Color(0xFFA3A3AC);

  /// Spacer
  static Widget vSpacer2 = const SizedBox(height: 2);
  static Widget vSpacer4 = const SizedBox(height: 4);
  static Widget vSpacer6 = const SizedBox(height: 6);
  static Widget vSpacer8 = const SizedBox(height: 8);
  static Widget vSpacer10 = const SizedBox(height: 10);
  static Widget vSpacer12 = const SizedBox(height: 12);
  static Widget vSpacer16 = const SizedBox(height: 16);
  static Widget vSpacer20 = const SizedBox(height: 20);
  static Widget vSpacer30 = const SizedBox(height: 30);
  static Widget vSpacer90 = const SizedBox(height: 90);

  static Widget hSpacer2 = const SizedBox(width: 2);
  static Widget hSpacer4 = const SizedBox(width: 4);
  static Widget hSpacer6 = const SizedBox(width: 6);
  static Widget hSpacer8 = const SizedBox(width: 8);
  static Widget hSpacer10 = const SizedBox(width: 10);
  static Widget hSpacer12 = const SizedBox(width: 12);
  static Widget hSpacer16 = const SizedBox(width: 16);
  static Widget hSpacer20 = const SizedBox(width: 20);

  ///Border
  static const double marginEdge = 16;
  static const double radius = 8;
  static const double dividerHeight = 1;
  static const double borderWidth = 1;

  /// Calendar
  static List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  static List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  //Color
  static Color BOX_SELECTED_COLOR = mainColor();
  static Color BOX_TODAY_COLOR = mainColor();
  static Color EVENT_DOT_COLOR = Colors.red;
  static Color DAY_TEXT_SELECTED = Colors.white;
  static Color DAY_TEXT_OTHER = Colors.grey;
  static Color DAY_TEXT_NORMAL = Colors.black;
  static Color DOT_COLOR = Colors.red;
  static Color DOW_TEXT_COLOR = Colors.black;

//header day of week
  static double DOW_TEXT_SIZE = 15.0;

  /// Store id
  static String iOSPeriodTrackerAppId = '1528917480';
  static String androidPeriodTrackerAppId = '1528917480';
  static String audioPath = 'asset:///assets/data/audios/';

  static List<String> locations = [
    'Hà Nội',
    'Hồ Chí Minh',
    'Đà Nẵng',
    'Hải Phòng'
  ];

}

enum KnowLedgeType {
  story(0),
  beforePregnancy(1),
  inPregnancy(2),
  inHospital(3),
  afterPregnancy(4),
  experiences(5),
  nutrition(6),
  makeFood(7);

  final int value;

  const KnowLedgeType(this.value);

  @override
  int toInt() {
    return value;
  }
}