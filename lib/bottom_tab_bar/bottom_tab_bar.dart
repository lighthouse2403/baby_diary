import 'package:flutter/material.dart';
import 'package:baby_diary/chat/chat.dart';
import 'package:baby_diary/common/constants/constants.dart';
import 'package:baby_diary/common/extension/font_size_extension.dart';
import 'package:baby_diary/common/extension/font_weight_extension.dart';
import 'package:baby_diary/common/extension/text_color_extension.dart';
import 'package:baby_diary/common/firebase/firebase_user.dart';

class MainBottomTabBar extends StatefulWidget {
  const MainBottomTabBar({super.key});

  @override
  State<MainBottomTabBar> createState() => MainBottomTabBarState();
}

class MainBottomTabBarState extends State<MainBottomTabBar> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    const Chat()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IndexedStack(
          index: selectedIndex,
          children: tabs,
        ),
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        items: tabs.map((e) => _generateItem(tabs.indexOf(e))).toList(),
        currentIndex: selectedIndex,
        unselectedLabelStyle: const TextStyle().greyColor().text12().textW600(),
        selectedLabelStyle: const TextStyle().mainColor().text12().textW600(),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseUser.instance.addUser();
    FirebaseUser.instance.updateLastTime();
  }

  /// Generate item colors
  Color _generateItemColor(int index) {
    Color itemColor = selectedIndex == index ? Constants.mainColor() : Constants.secondaryTextColor();
    return itemColor;
  }

  /// Generate item text style
  TextStyle _generateTextStyle(int index) {
    Color labelColor = _generateItemColor(index);
    return TextStyle(color: labelColor).textW500().text12();
  }

  /// Generate icon for each item
  Widget _generateIcon(int index) {
    Widget icon = Constants.bottomTabBarItems[index].icon.svg(
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(_generateItemColor(index), BlendMode.srcIn));
    return Column(
      children: [
        icon,
        const SizedBox(height: 4),
        Text(
          Constants.bottomTabBarItems[index].title,
          style: _generateTextStyle(index),
        )
      ],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  BottomNavigationBarItem _generateItem(int index) {
    return BottomNavigationBarItem(
      icon: _generateIcon(index),
      label: '',
    );
  }
}