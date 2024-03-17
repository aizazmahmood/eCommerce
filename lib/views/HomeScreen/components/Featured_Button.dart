import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/views/CategoryScreen/CategoryDetail.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semiBold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .roundedSM
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .make().onTap(() {
        Get.to(()=> CategoryDetails(title: title));
  });
}
