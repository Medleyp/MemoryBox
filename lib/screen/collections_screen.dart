import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_box/screen/add_collection_screen.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/bottom_navigation.dart';

import '../widgets/widgets.dart';

class CollectionScreen extends StatefulWidget {
  static const routeName = '/collections';
  final Function setAction;
  final Function setLeading;
  final Function setIndex;

  const CollectionScreen({
    required this.setAction,
    required this.setLeading,
    required this.setIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void dispose() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.setAction();
      widget.setLeading();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.setAction(
        horizAppBarAction(),
      );
      widget.setLeading(
        IconButton(
          onPressed: () {
            widget.setIndex(5);
          },
          icon: SvgPicture.asset('assets/icons/Add.svg'),
        ),
      );
    });

    return paintedScaffold(
        backgroudColor: Constants.collectionColor,
        body: Column(
          children: [
            Text(
              'Все в одном месте',
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ));
  }
}
