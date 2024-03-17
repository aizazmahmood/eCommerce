import 'package:pointofsale/consts/consts.dart';

Widget homeButton({width,height,icon,String? title,onPress}) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        10.heightBox,
        title!.text.fontFamily(semiBold).make(),

      ],
    ).box.white.size(width, height).rounded.shadowSm.make();
}
