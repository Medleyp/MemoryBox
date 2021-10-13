import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:memory_box/screen/audio_rec_screen.dart';
import 'package:memory_box/screen/collections_screen.dart';
import 'package:memory_box/screen/home_screen.dart';
import 'package:memory_box/screen/profile_screen.dart';
import 'package:memory_box/screen/record_screen.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/bottom_navigation.dart';

import 'package:memory_box/widgets/drawer.dart';

import 'add_collection_screen.dart';

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

  void setCurrentIndex(int index, [bool shouldPop = false]) {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Widget> screens = [
      HomeScreen(setCurrentIndex),
      CollectionScreen(
        setAction: setAction,
        setLeading: setAppBarLeading,
        setIndex: setCurrentIndex,
      ),
      const RecordScreen(),
      AudioRecordings(setAction),
      ProfileScreen(setAppBarLeading),
      AddCollectionScreen(setCurrentIndex),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigation(setIndex: setCurrentIndex),
      appBar: currentIndex == 0 || currentIndex == 5
          ? null
          : AppBar(
              centerTitle: true,
              backgroundColor: Constants.appBarColors[currentIndex],
              elevation: 0,
              leading: _appBarLeding,
              title: Text(
                Constants.appBarTitles[currentIndex],
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 36),
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
