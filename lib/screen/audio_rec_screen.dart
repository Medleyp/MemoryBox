import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/service/audio_service.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/audio_items.dart';
import 'package:memory_box/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AudioRecordings extends StatefulWidget {
  static const routeName = '/records';
  final Function setAction;
  const AudioRecordings(this.setAction, {Key? key}) : super(key: key);

  @override
  State<AudioRecordings> createState() => _AudioRecordingsState();
}

class _AudioRecordingsState extends State<AudioRecordings> {
  String _subtitleText = '';
  bool _isInit = false;
  late UserModel _userModel;

  Widget _buildRepeatButton() {
    final BorderRadius borderRaduis = BorderRadius.circular(30);
    return Stack(
      children: [
        Container(
          height: 43,
          width: 190,
          decoration: BoxDecoration(
            borderRadius: borderRaduis,
            color: const Color(0xFFF6F6F6).withOpacity(0.2),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 43,
            width: 145,
            decoration: BoxDecoration(
              borderRadius: borderRaduis,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Constants.purpleColor,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Запустить все',
                    style: TextStyle(
                      fontFamily: 'TTNorms',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF8C84E2),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Constants.repeatIcon,
          left: 153,
          top: 9,
        )
      ],
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.setAction(
        horizAppBarAction(),
      );
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _userModel = Provider.of<UserModel>(context);
      setState(() {
        _isInit = true;
        int duration = AudioService.getIntDuration(_userModel.audio);

        int hours = (duration ~/ 60);
        int minutes = (duration % 60);

        String strMinutes =
            minutes >= 10 ? (minutes).toString() : '0' + minutes.toString();

        strMinutes += ' ' + AudioService.getHoursEnding(hours);

        _subtitleText =
            ('${_userModel.audio.length} аудио\n') + '$hours:$strMinutes';
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.setAction();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userModel = Provider.of<UserModel>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.setAction(
        horizAppBarAction(),
      );
    });

    return paintedScaffold(
        backgroudColor: Constants.audioFilesColor,
        drawHeight: 180,
        body: Column(
          children: [
            Text(
              'Все в одном месте',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _subtitleText,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  _buildRepeatButton()
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 400,
              child: buildListWithAudio(
                // : context,
                userModel: _userModel,
                itemCount: _userModel.audio.length,
                audioColor: Constants.audioFilesColor,
              ),
            )
          ],
        ));
  }
}
