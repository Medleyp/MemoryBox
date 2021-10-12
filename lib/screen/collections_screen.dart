import 'package:flutter/material.dart';
import 'package:memory_box/service/constants.dart';

import '../widgets/widgets.dart';

class CollectionScreen extends StatelessWidget {
  static const routeName = '/collections';
  static const Color appBarColor = Constants.collectionColor;
  static const String appBarText = 'Подборки';

  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return paintedScaffold(
      backgroudColor: Constants.collectionColor,
      body: const Center(
        child: Text('Collections'),
      ),
    );
  }
}
