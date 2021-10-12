import 'package:flutter/material.dart';
import 'package:memory_box/model/user_model.dart';
import 'package:memory_box/screen/entry/registration_screen.dart';
import 'package:memory_box/service/constants.dart';
import 'package:memory_box/widgets/widgets.dart';

Dialog acceptDialog(
  BuildContext context,
  UserModel userModel, {
  required double height,
  required double width,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    child: SizedBox(
      height: height * 0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 5),
          Text(
            'Точно удалить аккаунт?',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Constants.textColor),
          ),
          SizedBox(
            width: width * 0.46,
            child: Text(
              'Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно',
              style: TextStyle(
                fontFamily: 'TTNorms',
                fontSize: 14,
                color: Constants.textColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  userModel.deleteUser();
                  Navigator.of(context)
                      .pushReplacementNamed(RegistrationScreen.routeName);
                },
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE27777),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Удалить',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.purpleColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Нет',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Constants.purpleColor),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Dialog verifyNumberDialog(
  BuildContext context,
  TextEditingController otpContoroller, {
  required double height,
  required double width,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    child: SizedBox(
      height: height * 0.33,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          SizedBox(
            width: width * 0.51,
            child: Text(
              'Введите код из смс, чтобы подтвердить номер телефона',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          buildCardWithTextField(context, otpContoroller),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Ок'),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String text,
    [TextButton? textButton]) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Ошибка', style: Theme.of(context).textTheme.headline5),
      content: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        if (textButton != null) textButton,
        const SizedBox(width: 40),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Ок',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w200),
          ),
        ),
      ],
    ),
  );
}

Dialog acceptDeletAudio({
  required BuildContext context,
  required UserModel userModel,
  required String songTitle,
  required double height,
  required double width,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    child: SizedBox(
      height: height * 0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 5),
          Text(
            'Подтверждаете удаление?',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: const Color(0xFFE27777)),
          ),
          SizedBox(
            width: width * 0.54,
            child: Text(
              'Ваш файл перенесется в папку\n"Недавно удаленные"\n. Через 15 дней он исчезнет.',
              style: TextStyle(
                fontFamily: 'TTNorms',
                fontSize: 14,
                color: Constants.textColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  userModel.deleAudio(songTitle);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Constants.purpleColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Да',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.purpleColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Нет',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Constants.purpleColor),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
