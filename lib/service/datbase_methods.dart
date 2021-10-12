import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memory_box/service/file_service.dart';

import '/model/user_model.dart';
import '/service/audio_service.dart';
import '/service/shared_prefs_service.dart';

class DataBaseMethods {
  static final _fireStore = FirebaseFirestore.instance;

  static Future<void> updateData({
    required String uid,
    required String fieldName,
    required String data,
  }) async {
    await _fireStore.collection('users').doc(uid).update({fieldName: data});
  }

  static Future<void> delelteAudio(
    String uid,
    String songTitle,
    String url,
  ) async {
    await _fireStore
        .collection('users')
        .doc(uid)
        .collection('audio')
        .doc(songTitle)
        .delete();
    await FileServise.deleteFileFromUrl(url);
  }

  static Future<void> uploadUserInfo(
    UserModel userModel,
    String phoneNumber,
    String uid,
  ) async {
    DocumentSnapshot result =
        await _fireStore.collection('users').doc(uid).get();
    if (!result.exists) {
      Map<String, String> userInfo = {
        'phone': phoneNumber,
        'name': 'User',
        'imageUrl':
            'https://paturskasvc.lv/wp-content/uploads/2020/11/user-alt-512.png',
        'mb': '500',
      };
      userModel.setUserInfo(uid, userInfo, []);
      await _fireStore.collection('users').doc(uid).set(userInfo);
    } else {
      List<Map<String, String>> audioInfo =
          await DataBaseMethods.getAudioListINfo(uid);
      userModel.setUserInfo(
        uid,
        result.data() as Map<String, dynamic>,
        audioInfo,
      );
    }
  }

  static Future<Map<String, dynamic>> loggedUserInfo(String uid) async {
    DocumentSnapshot result =
        await _fireStore.collection('users').doc(uid).get();
    return result.data() as Map<String, dynamic>;
  }

  static Future<void> addNewAudio(
    String uid,
    String title,
    String url,
    String strDuration,
    String intDuration,
  ) async {
    await _fireStore
        .collection('users')
        .doc(uid)
        .collection('audio')
        .doc(title)
        .set({
      'url': url,
      'strDuration': strDuration,
      'intDuration': intDuration,
    });
  }

  static Future<List<Map<String, String>>> getAudioListINfo(String uid) async {
    List<Map<String, String>> audioList = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('users').doc(uid).collection('audio').get();
    snapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data();
      audioList.add({
        'title': element.id,
        'strDuration': data['strDuration'],
        'intDuration': data['intDuration'],
        'url': data['url'],
      });
    });
    return audioList;
  }

  static Future<void> delete(String uid) async {
    DocumentReference ref = _fireStore.collection('users').doc(uid);
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ref.collection('audio').get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    await _fireStore.collection('users').doc(uid).delete();
    await SharedPrefService.delete();
  }

  static Future<List<String>> getAudioLinks(String uid) async {
    List<String> audioUrls = [];
    DocumentReference ref = _fireStore.collection('usrs').doc(uid);
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ref.collection('auido').get();
    for (var doc in snapshot.docs) {
      audioUrls.add(doc.data()['url']);
    }
    return audioUrls;
  }
}
