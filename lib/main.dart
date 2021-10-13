import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_box/model/user_model.dart';

import 'package:memory_box/screen/collections_screen.dart';

import 'package:provider/provider.dart';

import 'screen/entry/splash_sreen.dart';
import 'screen/control_screen.dart';
import 'screen/entry/registration_screen.dart';
import 'widgets/main_theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserModel())],
      child: MaterialApp(
        theme: ThemeData(
          textButtonTheme: textButtonTheme,
          elevatedButtonTheme: elevatedButtonTheme,
          textTheme: textTheme,
        ),
        title: 'MemoryBox',
        home: const SplashScreen(),
        routes: {
          ControlScreen.routeName: (_) => const ControlScreen(),
          RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        },
      ),
    );
  }
}
