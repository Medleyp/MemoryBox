import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/widgets/audio_items.dart';
import 'package:memory_box/widgets/main_theme.dart';
import 'package:memory_box/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Function setIndex;
  const HomeScreen(this.setIndex, {Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Text _buildCardText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline4!,
    );
  }

  Card _buildRoundedCard({
    required Color color,
    required double width,
    required double height,
    required Widget child,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color.withOpacity(0.9),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    UserModel userModel = Provider.of<UserModel>(context);

    return Builder(builder: (scaffoldContext) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            leading: IconButton(
              onPressed: () {
                Scaffold.of(scaffoldContext).openDrawer();
              },
              icon: hamburgerIcon,
            ),
            backgroundColor: const Color(0xFFF6F6F6),
            expandedHeight: height * 0.52 > 370 ? height * 0.52 : 370,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomPaint(
                painter: PurplePainter(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5, right: 8, left: 8, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 17.0,
                          left: 8.0,
                          right: 8.0,
                          top: 7,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Подборки',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'Открыть все',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRoundedCard(
                            color: const Color(0xFF71A59F),
                            width: width * 0.45, //171,
                            height: height * 0.32, //240,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 45, right: 25, left: 25, bottom: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildCardText(
                                      'Здесь будет твой набор сказок'),
                                  TextButton(
                                    onPressed: () async {
                                      userModel.printAudio();
                                    },
                                    child: underlinedText(
                                        context: context, text: 'Добавить'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            children: [
                              _buildRoundedCard(
                                color: const Color(0xFFF1B488),
                                width: width * 0.445,
                                height: height * 0.15,
                                child: _buildCardText('Тут'),
                              ),
                              const SizedBox(height: 5),
                              _buildRoundedCard(
                                color: const Color(0xFF678BD2),
                                width: width * 0.445,
                                height: height * 0.15,
                                child: _buildCardText('И тут'),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverAudioList(setIndex: widget.setIndex),
        ],
      );
    });
  }
}
