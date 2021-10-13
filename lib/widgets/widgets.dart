import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memory_box/service/constants.dart';

class PurplePainter extends CustomPainter {
  final bool _showAppBar;
  final Color _color;
  final double? _drawHeight;
  PurplePainter(
      {bool showAppBar = false,
      Color color = Constants.purpleColor,
      double? drawHeight})
      : _showAppBar = showAppBar,
        _color = color,
        _drawHeight = drawHeight;

  @override
  void paint(Canvas canvas, Size size) {
    double additionalHeight = _showAppBar ? 80 : 0;
    final double width = size.width;

    Paint paint = Paint();
    paint.color = _color;

    Path purpleBackground = Path()
      ..moveTo(0, (_drawHeight != null ? _drawHeight! : 220) - additionalHeight)
      ..quadraticBezierTo(
        160,
        (_drawHeight != null ? _drawHeight! + 80 : 325) - additionalHeight,
        width,
        (_drawHeight != null ? _drawHeight! + 28 : 275) - additionalHeight,
      )
      ..lineTo(width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(purpleBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

Container paintedContainer({
  required BuildContext context,
  required Widget child,
  bool showDrawer = false,
}) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        children: [
          CustomPaint(
            painter: PurplePainter(),
            child: SizedBox(
              width: double.infinity,
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}

Scaffold paintedScaffold({
  required Widget body,
  AppBar? appBar,
  Color backgroudColor = Constants.purpleColor,
  double? drawHeight,
}) {
  return Scaffold(
    appBar: appBar,
    backgroundColor: const Color(0xFFF6F6F6),
    body: SingleChildScrollView(
      child: Column(
        children: [
          CustomPaint(
            painter: PurplePainter(
              showAppBar: true,
              color: backgroudColor,
              drawHeight: drawHeight,
            ),
            child: SizedBox(
              width: double.infinity,
              child: body,
            ),
          ),
        ],
      ),
    ),
  );
}

Text underlinedText({
  required BuildContext context,
  required String text,
  bool isWhite = true,
}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.subtitle1!.copyWith(
          decorationColor: isWhite ? Colors.white : Constants.textColor,
          decoration: TextDecoration.underline,
          shadows: [
            Shadow(
              color: isWhite ? Colors.white : Constants.textColor,
              offset: const Offset(0, -5),
            )
          ],
          color: Colors.transparent,
        ),
  );
}

Card buildCardWithTextField(
    BuildContext context, TextEditingController controller,
    {bool? enabled}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
    ),
    child: SizedBox(
      height: 60,
      child: buildTextField(context, controller, enabled: enabled),
    ),
  );
}

TextField buildTextField(
  BuildContext context,
  TextEditingController controller, {
  bool? enabled,
  TextInputType keyboardType = TextInputType.phone,
  bool showBorder = false,
}) {
  return TextField(
    cursorColor: Colors.black45,
    textAlign: TextAlign.center,
    enabled: enabled == false ? false : null,
    controller: controller,
    keyboardType: keyboardType,
    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.only(top: 10),
      focusedBorder: showBorder
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.textColor))
          : null,
      enabledBorder: showBorder
          ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.textColor))
          : null,
    ),
  );
}

Widget horizAppBarAction() {
  return IconButton(
    onPressed: () {},
    icon: SvgPicture.asset(
      'assets/icons/More_horiz.svg',
      color: Colors.white,
    ),
  );
}

Widget backArrowAppBar(VoidCallback onPrassed) {
  return Container(
    margin: const EdgeInsets.only(left: 9, top: 9),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: IconButton(
      onPressed: onPrassed,
      icon: SvgPicture.asset('assets/icons/Arrow - Left Circle.svg'),
    ),
  );
}
