import 'package:pointofsale/consts/consts.dart';

Widget ourButton({onPress, textColor, String? title, color}) {
  return ElevatedButton(
      onPressed:
        onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      child: title!.text.color(textColor).fontFamily(bold).make());
}
