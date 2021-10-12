import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_box/widgets/dialogs.dart';
import 'package:provider/provider.dart';

import '/service/shared_prefs_service.dart';
import '/service/auth_serivce.dart';
import '/service/datbase_methods.dart';

import 'package:memory_box/model/user_model.dart';

import 'home_widgets.dart';
import 'package:memory_box/widgets/widgets.dart';
import 'end_registration_screen.dart.dart';
import '../control_screen.dart';
import 'welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  final AuthService _authService = AuthService.getInstance();

  final Card _bottomCard = Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Регистрация привяжет твои скаски\nк облаку, после чего они всегда\nбудут с тобой',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'TTNorms', fontSize: 14, fontWeight: FontWeight.normal),
      ),
    ),
  );

  List<Widget> _registrationTitle(double height) {
    return [
      SizedBox(height: height * 0.19 > 130 ? height * 0.19 : 130),
      Text(
        'Регистация',
        style: Theme.of(context).textTheme.headline6,
      ),
    ];
  }

  TextButton _buildNextTimeButton() {
    return TextButton(
      onPressed: () async {
        User? result = await _authService.signInAnon();
        if (result == null) {
          print('ERRRRORR UTH');
        } else {
          print('Signed IN');
        }
        Navigator.of(context).pushReplacementNamed(ControlScreen.routeName);
      },
      child: Text(
        'Позже',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Container _registrationScreen(double height, {VoidCallback? buttonFunction}) {
    return paintedContainer(
      context: context,
      child: Column(
        children: [
          ..._registrationTitle(height),
          SizedBox(height: height * 0.17 > 115 ? height * 0.17 : 115),
          bodyText1(context, 'Введи номер телефона'),
          const SizedBox(height: 20),
          buildCardWithTextField(context, _phoneController),
          const SizedBox(height: 75),
          buildCustomButton(
              text: 'Продлжить', function: buttonFunction ?? () {}),
          const SizedBox(height: 10),
          _buildNextTimeButton(),
          _bottomCard,
        ],
      ),
    );
  }

  Container _validationScreen(double height, {VoidCallback? buttonFunction}) {
    return paintedContainer(
      context: context,
      child: Column(children: [
        ..._registrationTitle(height),
        SizedBox(height: height * 0.17 > 115 ? height * 0.17 : 115),
        bodyText1(context, 'Введите код из смс, чтобы мы\n тебя запомнили'),
        const SizedBox(height: 20),
        buildCardWithTextField(context, _otpController),
        const SizedBox(height: 55),
        buildCustomButton(text: 'Продлжить', function: buttonFunction ?? () {}),
        const SizedBox(height: 55),
        _bottomCard,
      ]),
    );
  }

  // void _showErrorDialog(String text, [TextButton? textButton]) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Ошибка', style: Theme.of(context).textTheme.headline5),
  //       content: Text(
  //         text,
  //         style: Theme.of(context).textTheme.bodyText1,
  //       ),
  //       actions: [
  //         if (textButton != null) textButton,
  //         const SizedBox(width: 40),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text(
  //             'Ок',
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .bodyText1!
  //                 .copyWith(fontWeight: FontWeight.w200),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    return PageView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        WelcomeScreen(
          pageController: _pageController,
        ),

        _registrationScreen(height, buttonFunction: () async {
          if (_phoneController.text.isEmpty) {
            await showErrorDialog(context, 'Введите номер телефона');
            return;
          }

          await _authService.verifyPhoneNumber(
            context,
            _phoneController.text,
            pageController: _pageController,
          );

          _pageController.animateToPage(
            2,
            duration: const Duration(seconds: 1, milliseconds: 350),
            curve: Curves.decelerate,
          );
        }),
        _validationScreen(
          height,
          buttonFunction: () async {
            try {
              if (_otpController.text.isEmpty) {
                await showErrorDialog(context, 'Введить код из смс');
                return;
              }
              final uid =
                  await _authService.signInWithCredentials(_otpController.text);

              await DataBaseMethods.uploadUserInfo(
                  _userModel, _phoneController.text, uid!);
              await SharedPrefService.saveUserLoggedIn(uid, true);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const EndRegistrationScreen(),
                ),
              );
            } catch (e) {
              await showErrorDialog(
                context,
                'Не правильный код! Проверить номер телефона',
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _pageController.jumpToPage(1);
                  },
                  child: Text(
                    'Проверить телефон',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                ),
              );
            }
          },
        ), // Validation Form
      ],
    );
  }
}
