import 'package:pointofsale/consts/consts.dart';

Widget orderPlacedDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1.text.fontFamily(semiBold).make(),
            d1.text.fontFamily(semiBold).color(redColor).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title2.text.fontFamily(semiBold).make(),
              d2.text.fontFamily(semiBold).color(redColor).make(),
            ],
          ),
        ),
      ],
    ),
  );
}
