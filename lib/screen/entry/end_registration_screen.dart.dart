import 'dart:async';

import 'package:flutter/material.dart';

import 'package:memory_box/widgets/widgets.dart';
import '../control_screen.dart';
import 'home_widgets.dart';

class EndRegistrationScreen extends StatefulWidget {
  final bool _regularUserScreen;
  const EndRegistrationScreen({Key? key, regularUserScreen = false})
      : _regularUserScreen = regularUserScreen,
        super(key: key);

  @override
  State<EndRegistrationScreen> createState() => _EndRegistrationScreenState();
}

class _EndRegistrationScreenState extends State<EndRegistrationScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 2, milliseconds: 300),
        () => Navigator.of(context)
            .pushReplacementNamed(ControlScreen.routeName));
    super.initState();
  }

  final Card _bottomCard = Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Взрослые иногда нуждаются в\n сказке даже больше, чем дети',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'TTNorms', fontSize: 14, fontWeight: FontWeight.normal),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return paintedContainer(
      context: context,
      child: Column(
        children: [
          SizedBox(height: height * 0.19 > 130 ? height * 0.19 : 130),
          widget._regularUserScreen
              ? buildMemoryBoxTitle(context)
              : Text(
                  'Ты супер',
                  style: Theme.of(context).textTheme.headline6,
                ),
          SizedBox(height: height * 0.16 > 110 ? height * 0.16 : 110),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Мы рады тебя видеть',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Icon(
            Icons.favorite,
            size: 60,
            color: Color(0xFFF1B488),
          ),
          const SizedBox(height: 60),
          _bottomCard
        ],
      ),
    );
  }
}
