import 'package:flutter/services.dart';
import 'package:pointofsale/consts/consts.dart';

Widget ExitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        const Divider(),
        10.heightBox,
        "Would you like to exit this app?"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor,title: "Yes",textColor: whiteColor,onPress: (){
              SystemNavigator.pop();
            }),
            ourButton(color: redColor,title: "No",textColor: whiteColor,onPress: (){
              Navigator.pop(context);
            }),

          ],
        ),

      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
