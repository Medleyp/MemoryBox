import 'package:flutter/material.dart';

import 'home_widgets.dart';

import '../../widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController pageController;
  const WelcomeScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return paintedContainer(
      context: context,
      child: Column(
        children: [
          SizedBox(height: height * 0.19 > 130 ? height * 0.19 : 130),
          buildMemoryBoxTitle(context),
          SizedBox(height: height * 0.15 > 110 ? height * 0.15 : 110),
          Text(
            'Привет!',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 310,
            child: bodyText1(
              context,
              'Мы ради видеть тебя здесь.\n Это приложение поможет записывать сказки и держать их в удобном месте не заполняя память на телефоне',
            ),
          ),
          const SizedBox(height: 45),
          buildCustomButton(
            text: 'Продолжить',
            function: () {
              pageController.animateToPage(
                1,
                duration: const Duration(seconds: 1, milliseconds: 350),
                curve: Curves.decelerate,
              );
            },
          ),
        ],
      ),
    );
  }
}
