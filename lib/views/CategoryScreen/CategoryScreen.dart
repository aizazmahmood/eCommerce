import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/ProductController.dart';
import 'package:pointofsale/views/CategoryScreen/CategoryDetail.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return backgroundWidget(
      child: Scaffold(
        appBar: AppBar(title: categriz.text.white.fontFamily(bold).make()),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  "$categoriesList[index]"
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                controller.getSubCategories(title: categoriesList[index]);
                Get.to(()=>CategoryDetails(title: categoriesList[index]),);
              });
            },
          ),
        ),
      ),
    );
  }
}
