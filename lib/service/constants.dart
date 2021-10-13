import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Constants {
  static const Color purpleColor = Color(0xFF8077E4);
  static const Color textColor = Color(0xFF3A3A55);
  static const Color sendColor = Color(0xFFF1B488);
  static const Color audioFilesColor = Color(0xFF5E77CE);
  static const Color collectionColor = Color(0xFF71A59F);
  static const Color whiteColor = Color(0xFFF6F6F6);

  static const String usesProfileImageIrl =
      'https://paturskasvc.lv/wp-content/uploads/2020/11/user-alt-512.png';

  static SvgPicture humburgerIcon =
      SvgPicture.asset('assets/icons/Menu.svg', height: 18);
  static SvgPicture repeatIcon =
      SvgPicture.asset('assets/icons/Repeat.svg', color: Colors.white);

  static const List<String> appBarTitles = [
    '',
    'Подборки',
    ' ',
    'Аудиозаписи',
    'Профиль',
    'Тайтл',
  ];
  static const List<Color> appBarColors = [
    Constants.purpleColor,
    Constants.collectionColor,
    Constants.purpleColor,
    Constants.audioFilesColor,
    Constants.purpleColor,
    Constants.audioFilesColor,
  ];

  //height = 759
  //width = 393
}
