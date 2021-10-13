import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_box/service/constants.dart';

class BottomNavigation extends StatefulWidget {
  final Function setIndex;
  const BottomNavigation({
    required this.setIndex,
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  Radius radius = const Radius.circular(25);
  TextStyle textStyle = const TextStyle(
    fontFamily: 'TTNorms',
    color: Constants.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: radius,
          topLeft: radius,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: textStyle,
          unselectedLabelStyle: textStyle,
          currentIndex: currentIndex > 4 ? 1 : currentIndex,
          selectedItemColor: Constants.purpleColor,
          onTap: (index) {
            setState(() => currentIndex = index);
            widget.setIndex(currentIndex);
          },
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
}
