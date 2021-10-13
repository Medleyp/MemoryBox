import 'dart:io';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/dialogs.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/model/user_model.dart';
import '/service/file_service.dart';

import '../widgets/widgets.dart';

class RecordScreen extends StatefulWidget {
  static const routeName = '/recording';

  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  File? file;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final fileName = file != null ? basename(file!.path) : '';
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : paintedScaffold(
            body: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    file = await FileServise.pickFile();
                    if (file == null) {
                      await showErrorDialog(
                        context,
                        'Выберите правельный формат файла',
                      );
                      return;
                    }
                    ;
                  },
                  child: const Text('Add recordings'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    String url =
                        await FileServise.storeAudionAndGetUrl(user.uid, file!);
                    await user.addNewAudio(basename(file!.path), url);

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: const Text('Upload'),
                )
              ],
            ),
          );
  }
}
