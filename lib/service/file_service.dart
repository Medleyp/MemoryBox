import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/service/datbase_methods.dart';

import 'package:file_picker/file_picker.dart';

class FileServise {
  static Future<File?> pickFile({String? fileExstention}) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return null;

    final path = result.files.single.path!;
    print(context.extension(path));
    print(fileExstention);
    if (fileExstention != null && context.extension(path) != fileExstention) {
      print('REturned');
      return null;
    }

    return File(path);
  }

  static Future<String> _uploadTaskAndGetUrl(
      String destination, File file) async {
    final ref = FirebaseStorage.instance.ref(destination);
    UploadTask? task = ref.putFile(file);

    final snapshot = await task.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  static Future<String> storeImageAndGetUrl(String uid, File file) async {
    final destination = '$uid/${basename(file.path)}';

    return await _uploadTaskAndGetUrl(destination, file);
  }

  static Future<String> storeAudionAndGetUrl(String uid, File file) async {
    final destination = '$uid/audio/${basename(file.path)}';

    return _uploadTaskAndGetUrl(destination, file);
  }

  static Future<void> clearRootFolder(UserModel userModel) async {
    for (Map<String, String> audioData in userModel.audio) {
      await deleteFileFromUrl(audioData['url']!);
    }

    if (userModel.imageUrl != Constants.usesProfileImageIrl) {
      await deleteFileFromUrl(userModel.imageUrl);
    }
  }

  static Future<void> deleteFileFromUrl(String url) async {
    final FirebaseStorage instance = FirebaseStorage.instance;
    await instance.refFromURL(url).delete();
  }
}
