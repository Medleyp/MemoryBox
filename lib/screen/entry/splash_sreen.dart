import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/service/constants.dart';

import '/model/user_model.dart';
import '/service/datbase_methods.dart';
import '/service/shared_prefs_service.dart';

import 'end_registration_screen.dart.dart';
import 'registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _choseAndSwitchScreen(bool result) {
    if (result) {
      _uploadUserInfoIfLogged().then(
        (_) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const EndRegistrationScreen(
              regularUserScreen: true,
            ),
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(RegistrationScreen.routeName);
    }
  }

  Future<void> _uploadUserInfoIfLogged() async {
    final uid = await SharedPrefService.getUid();
    final info = await DataBaseMethods.loggedUserInfo(uid);
    final audioInfo = await DataBaseMethods.getAudioListINfo(uid);

    Provider.of<UserModel>(context, listen: false)
        .setUserInfo(uid, info, audioInfo);
  }

  @override
  void initState() {
    SharedPrefService.getUserLoggedIn().then((bool result) {
      Timer(const Duration(seconds: 3), () {
        _choseAndSwitchScreen(result);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFFF1B488),
            Constants.purpleColor,
          ],
          stops: [0.1, 0.7],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MemoryBox',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: Colors.white),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/Voice.svg',
                    height: 20,
                    width: 16,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
