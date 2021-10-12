import 'package:flutter/cupertino.dart';
import 'package:memory_box/service/audio_service.dart';
import 'package:memory_box/service/auth_serivce.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/service/datbase_methods.dart';
import 'package:memory_box/service/file_service.dart';

class UserModel with ChangeNotifier {
  late String uid;
  late String _phone;
  late String _name;
  late String _imageUrl;
  late int mb;
  List<Map<String, String>> _audio = [];

  Future<void> setImageUrl(String imageUrl) async {
    if (_imageUrl != Constants.usesProfileImageIrl) {
      await FileServise.deleteFileFromUrl(_imageUrl);
    }
    _imageUrl = imageUrl;
    await DataBaseMethods.updateData(
      uid: uid,
      fieldName: 'imageUrl',
      data: imageUrl,
    );
  }

  Future<void> setName(String name) async {
    _name = name;
    await DataBaseMethods.updateData(
      uid: uid,
      fieldName: 'name',
      data: name,
    );
  }

  Future<void> setPhoneNumber(String phone) async {
    _phone = phone;
    await DataBaseMethods.updateData(
      uid: uid,
      fieldName: 'phone',
      data: _phone,
    );
  }

  String get name {
    return _name;
  }

  String get phone {
    return _phone;
  }

  String get imageUrl {
    return _imageUrl;
  }

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  void setUserInfo(
    String uid,
    Map<String, dynamic> info,
    List<Map<String, String>> audio,
  ) {
    this.uid = uid;
    _phone = info['phone']!;
    _name = info['name']!;
    _imageUrl = info['imageUrl']!;
    mb = int.parse(info['mb']);
    _audio = audio;

    notifyListeners();
  }

  Future<void> deleAudio(String songTitle) async {
    Map<String, String> audio =
        _audio.firstWhere((element) => element['title'] == songTitle);
    await DataBaseMethods.delelteAudio(uid, songTitle, audio['url']!);
    _audio.remove(audio);
    notifyListeners();
  }

  Future<void> addNewAudio(String title, String url) async {
    String strDuration = await AudioService.getStrDuratoin(url);
    String intDuration = (await AudioService.getMinutes(url)).toString();
    _audio.add({
      'title': title,
      'strDuration': strDuration,
      'intDuration': intDuration,
      'url': url,
    });
    await DataBaseMethods.addNewAudio(
      uid,
      title,
      url,
      strDuration,
      intDuration,
    );
    notifyListeners();
  }

  List<Map<String, String>> get audio {
    return List.from(_audio);
  }

  void printAudio() {
    _audio.forEach((element) {
      print(element);
    });
  }

  Future<void> deleteUser() async {
    await FileServise.clearRootFolder(this);
    await DataBaseMethods.delete(uid);
    await AuthService.getInstance().deleteUser();
  }
}
