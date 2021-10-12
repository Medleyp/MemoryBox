import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/dialogs.dart';
import 'package:provider/provider.dart';

enum PopAction {
  rename,
  addToCollection,
  delete,
  share,
}

class SliverAudioList extends StatelessWidget {
  final Function setIndex;

  const SliverAudioList({Key? key, required this.setIndex}) : super(key: key);

  Widget _buildCenterCardText(
      {required BuildContext context,
      required double height,
      required double width}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.05),
          width: width * 0.72,
          child: Text(
            'Как только ты запишешь аудио, она появится здесь',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: const Color(0xFF3A3A55).withOpacity(0.5),
                ),
          ),
        ),
        SizedBox(height: height * 0.09),
        SvgPicture.asset(
          'assets/icons/Arrow - Down.svg',
          height: height * 0.05,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final UserModel userModel = Provider.of<UserModel>(context);

    return SliverToBoxAdapter(
      child: Card(
        elevation: 10,
        shadowColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: const Color(0xFFF6F6F6),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Аудиозаписи',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    InkWell(
                      onTap: () {
                        setIndex(3, false);
                      },
                      child: Text(
                        'Открыть все',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: const Color(0xFF3A3A55)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250 > (120 + userModel.audio.length * 50)
                    ? 250
                    : 120 + userModel.audio.length * 60,
                child: userModel.audio.isEmpty
                    ? _buildCenterCardText(
                        context: context,
                        height: height,
                        width: width,
                      )
                    : buildListWithAudio(
                        userModel: userModel,
                        itemCount: userModel.audio.length > 15
                            ? 15
                            : userModel.audio.length,
                        audioColor: Constants.purpleColor,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildAudioItem({
  required BuildContext context,
  required UserModel userModel,
  required String title,
  required String subtitle,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 0, top: 3, bottom: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F6F6),
      border: Border.all(
        color: const Color(0xFF3A3A55).withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(35),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: color,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: const Color(0xFF3A3A55),
                    ),
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: const Color(0xFF3A3A55).withOpacity(0.5),
                  ),
            ),
          ],
        ),
        const Expanded(child: FittedBox()),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: _buildPopMenuButton(
            context,
            userModel,
            title,
          ),
        )
      ],
    ),
  );
}

// Additional widgets (Audio items)
ListView buildListWithAudio({
  required UserModel userModel,
  required int itemCount,
  ScrollPhysics? physics,
  required Color audioColor,
}) {
  return ListView.separated(
    physics: physics,
    itemCount: itemCount,
    separatorBuilder: (context, index) => const SizedBox(height: 10),
    itemBuilder: (BuildContext context, int index) {
      return buildAudioItem(
        context: context,
        userModel: userModel,
        color: audioColor,
        title: userModel.audio[index]['title'] as String,
        subtitle: userModel.audio[index]['strDuration'] as String,
      );
    },
  );
}

PopupMenuButton _buildPopMenuButton(
  BuildContext context,
  UserModel userModel,
  String songTitle,
) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  const TextStyle popUpTextStyle = TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Constants.textColor,
  );
  const double popUpHeight = 35;

  return PopupMenuButton(
    onSelected: (action) {
      if (action == PopAction.delete) {
        showDialog(
          context: context,
          builder: (_) {
            return acceptDeletAudio(
              context: context,
              userModel: userModel,
              songTitle: songTitle,
              height: height,
              width: width,
            );
          },
        );
      }
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    icon: const Icon(
      Icons.more_horiz,
      color: Color(0xFF3A3A55),
    ),
    itemBuilder: (_) => [
      const PopupMenuItem(
        value: PopAction.rename,
        child: Text(
          'Переименовать',
          style: popUpTextStyle,
        ),
        height: popUpHeight,
      ),
      const PopupMenuItem(
        value: PopAction.addToCollection,
        child: Text(
          'Добавит в подборку',
          style: popUpTextStyle,
        ),
        height: popUpHeight,
      ),
      const PopupMenuItem(
        value: PopAction.delete,
        child: Text(
          'Удалить',
          style: popUpTextStyle,
        ),
        height: popUpHeight,
      ),
      const PopupMenuItem(
        value: PopAction.share,
        child: Text(
          'Поделится',
          style: popUpTextStyle,
        ),
        height: popUpHeight,
      ),
    ],
  );
}
