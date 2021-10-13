import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/service/file_service.dart';
import 'package:memory_box/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddCollectionScreen extends StatefulWidget {
  final Function setIndex;
  const AddCollectionScreen(
    this.setIndex, {
    Key? key,
  }) : super(key: key);

  @override
  _AddCollectionScreenState createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  String? _imageUrl;
  TextEditingController _titleController = TextEditingController();

  Widget _builcImageCard(
    UserModel userModel, {
    required double height,
    required double width,
  }) {
    final BorderRadius borderRadius = BorderRadius.circular(15);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            color: Constants.whiteColor.withOpacity(0.9),
            child: SizedBox(
              height: 240,
              width: width,
              child: _imageUrl != null
                  ? ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.network(
                        _imageUrl!,
                        fit: BoxFit.fill,
                      ),
                    )
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                File? file = await FileServise.pickFile();
                if (file == null) return;
                String url = await FileServise.storeImageAndGetUrl(
                  userModel.uid,
                  file,
                );
                setState(() {
                  _imageUrl = url;
                });
              },
              child: Container(
                height: 235,
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: borderRadius),
                child: Center(
                  child: Container(
                    width: height * 0.11,
                    height: height * 0.11,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Constants.textColor.withOpacity(0.8),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/Camera.svg',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Создание',
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 36),
      ),
      backgroundColor: Constants.collectionColor,
      elevation: 0,
      leading: backArrowAppBar(() => widget.setIndex(1)),
      actions: [
        TextButton(
          onPressed: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Готово',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final UserModel userModel = Provider.of(context);

    return paintedScaffold(
      appBar: _buildAppBar(),
      backgroudColor: Constants.collectionColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Constants.whiteColor),
            ),
            _builcImageCard(userModel, height: height, width: width),
            Text(
              'Введите описание...',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            buildTextField(
              context,
              _titleController,
              keyboardType: TextInputType.text,
              showBorder: true,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Готово',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.07),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: underlinedText(
                    context: context,
                    text: 'Добавить аудиофайл',
                    isWhite: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
