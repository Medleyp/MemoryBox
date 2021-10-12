import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:memory_box/screen/audio_rec_screen.dart';
import 'package:memory_box/screen/collections_screen.dart';
import 'package:memory_box/screen/home_screen.dart';
import 'package:memory_box/screen/profile_screen.dart';
import 'package:memory_box/screen/record_screen.dart';
import 'package:memory_box/service/constants.dart';

import 'package:memory_box/widgets/drawer.dart';

class ControlScreen extends StatefulWidget {
  static const routeName = '/control';

  const ControlScreen({Key? key}) : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  int currentIndex = 0;
  Widget? _action;

  Widget _appBarLeding = Builder(builder: (scaffoldContext) {
    return IconButton(
      onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
      icon: SvgPicture.asset('assets/icons/Menu.svg', height: 18),
    );
  });

  void setCurrentIndex(int index, [bool shouldPop = true]) {
    if (shouldPop) Navigator.of(context).pop();
    setState(() {
      currentIndex = index;
    });
  }

  void setAction([Widget? action]) {
    setState(() {
      _action = action;
    });
  }

  void setAppBarLeading([Widget? widget]) {
    if (widget == null) {
      setState(() {
        _appBarLeding = Builder(builder: (scaffoldContext) {
          return IconButton(
            onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
            icon: Constants.humburgerIcon,
          );
        });
      });
    } else {
      setState(() {
        _appBarLeding = widget;
      });
    }
  }

  Container _buildBottomNavigation() {
    const Radius radius = Radius.circular(25);

    const TextStyle textStyle = TextStyle(
      fontFamily: 'TTNorms',
      color: Constants.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 10,
    );

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: radius,
          topLeft: radius,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: textStyle,
          unselectedLabelStyle: textStyle,
          currentIndex: currentIndex,
          selectedItemColor: Constants.purpleColor,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Home.svg',
                color: Constants.purpleColor,
              ),
              icon: SvgPicture.asset('assets/icons/Home.svg'),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Category.svg',
                color: Constants.purpleColor,
              ),
              icon: SvgPicture.asset('assets/icons/Category.svg'),
              label: 'Подборки',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1B488),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset('assets/icons/Voice.svg'),
                  ),
                ],
              ),
              label: 'Запись',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Paper.svg',
                color: Constants.purpleColor,
              ),
              icon: SvgPicture.asset('assets/icons/Paper.svg'),
              label: 'Аудиозаписи',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Profile.svg',
                color: Constants.purpleColor,
              ),
              icon: SvgPicture.asset('assets/icons/Profile.svg'),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Widget> screens = [
      HomeScreen(setCurrentIndex),
      const CollectionScreen(),
      const RecordScreen(),
      AudioRecordings(setAction),
      ProfileScreen(setAppBarLeading)
    ];

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(),
      appBar: currentIndex == 0
          ? null
          : AppBar(
              backgroundColor: Constants.appBarColors[currentIndex],
              elevation: 0,
              leading: _appBarLeding,
              title: Padding(
                padding: EdgeInsets.only(
                  left: (_action == null ? width * 0.15 : width * 0.1) -
                      Constants.appBarTitles[currentIndex].length * 3,
                ),
                child: FittedBox(
                  child: Text(
                    Constants.appBarTitles[currentIndex],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 36),
                  ),
                ),
              ),
              actions: _action == null ? [] : [_action!],
            ),
      drawer: CustomDrawer(setIndex: setCurrentIndex),
      extendBody: true,
      backgroundColor: const Color(0xFFF6F6F6),
      body: screens[currentIndex],
    );
  }
}
