import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:memory_box/service/shared_prefs_service.dart';
import 'package:memory_box/widgets/dialogs.dart';

class AuthService {
  static AuthService? _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;

  factory AuthService.getInstance() {
    return _instance ??= AuthService._init();
  }

  AuthService._init();

  Future<User?> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<String?> verifyPhoneNumber(BuildContext context, String phoneNumber,
      {PageController? pageController}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential verificationCompleted) {},
      verificationFailed: (FirebaseAuthException verificationFailed) async {
        await showErrorDialog(context, 'Неправельный формат номера ателефона');
        pageController?.jumpToPage(1);
      },
      codeSent: (String verificationId, int? resentToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  Future<String?> signInWithCredentials(String otpCode) async {
    try {
      UserCredential userCredential = await _auth.signInWithCredential(
        _getCredentials(otpCode),
      );
      return userCredential.user!.uid;
    } catch (e) {
      rethrow;
    }
  }

  PhoneAuthCredential _getCredentials(String otpCode) {
    return PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otpCode);
  }

  Future<void> updatePhoneNumber(String otpCode) async {
    await _auth.currentUser!.updatePhoneNumber(_getCredentials(otpCode));
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await SharedPrefService.saveSignOut();
  }

  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }
}
