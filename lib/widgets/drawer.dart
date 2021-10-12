import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  final Function setIndex;

  const CustomDrawer({Key? key, required this.setIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InkWell buildDrawerButton({
      required String iconAsset,
      required String text,
      required VoidCallback function,
    }) {
      return InkWell(
        onTap: function,
        child: Container(
          height: 45,
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 27,
              ),
              const SizedBox(width: 12),
              Text(text, style: Theme.of(context).textTheme.headline3),
            ],
          ),
        ),
      );
    }

    final height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Аудиосказки',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Меню',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 22,
                          color: const Color(0xFF3A3A55).withOpacity(0.5),
                        ),
                  )
                ],
              ),
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Home.svg',
              text: 'Главная',
              function: () => setIndex(0),
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Profile.svg',
              text: 'Профиль',
              function: () => setIndex(4),
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Category.svg',
              text: 'Подборки',
              function: () => setIndex(1),
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Paper.svg',
              text: 'Все аудиофайлы',
              function: () => setIndex(3),
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Search.svg',
              text: 'Поиск',
              function: () {},
            ),
            buildDrawerButton(
              iconAsset: 'assets/icons/Delete.svg',
              text: 'Недавно удаленные',
              function: () {},
            ),
            const SizedBox(height: 20),
            buildDrawerButton(
              iconAsset: 'assets/icons/Wallet.svg',
              text: 'Подписка',
              function: () {},
            ),
            const SizedBox(height: 30),
            buildDrawerButton(
              iconAsset: 'assets/icons/Edit.svg',
              text: 'Написать в\nподдержку',
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ClipRRect buildDrawer({
//   required BuildContext context,
//   required Function setIndex,
//   required double height,
//   required double width,
// }) {
//   return ClipRRect(
//     borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
//     child: Drawer(
//       child: Column(
//         children: [
//           SizedBox(
//             height: height * 0.28,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Аудиосказки',
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 const SizedBox(height: 35),
//                 Text(
//                   'Меню',
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontSize: 22,
//                         color: const Color(0xFF3A3A55).withOpacity(0.5),
//                       ),
//                 )
//               ],
//             ),
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Home.svg',
//             text: 'Главная',
//             function: () => setIndex(0),
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Profile.svg',
//             text: 'Профиль',
//             function: () => setIndex(4),
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Category.svg',
//             text: 'Подборки',
//             function: () => setIndex(1),
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Paper.svg',
//             text: 'Все аудиофайлы',
//             function: () => setIndex(3),
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Search.svg',
//             text: 'Поиск',
//             function: () {},
//           ),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Delete.svg',
//             text: 'Недавно удаленные',
//             function: () {},
//           ),
//           const SizedBox(height: 20),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Wallet.svg',
//             text: 'Подписка',
//             function: () {},
//           ),
//           const SizedBox(height: 30),
//           buildDrawerButton(
//             context: context,
//             iconAsset: 'assets/icons/Edit.svg',
//             text: 'Написать в\nподдержку',
//             function: () {},
//           ),
//         ],
//       ),
//     ),
//   );
// }
