import 'package:flutter/material.dart';

Widget buildCustomButton(
    {required String text, required VoidCallback function}) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      width: 260,
      height: 55,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Column buildMemoryBoxTitle(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'MemoryBox',
        style: Theme.of(context).textTheme.headline6,
      ),
      Text(
        'Твой голос всегда рядом',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    ],
  );
}

Text bodyText1(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1,
    textAlign: TextAlign.center,
  );
}
