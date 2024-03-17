import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/ProductController.dart';
import 'package:pointofsale/views/CategoryScreen/ItemDetails.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(title: widget.title);
  }

  switchCategory({title}) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title: title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.white.fontFamily(bold).make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                        .text
                        .size(12)
                        .fontFamily(semiBold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() {
                          switchCategory(title: controller.subcat[index]);
                          setState(() {

                          });
                    }),
                  )
                ],
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Products Found!".text.color(darkFontGrey).makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;

                  return Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_images'][0],
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semiBold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(
                                const EdgeInsets.symmetric(horizontal: 4),
                              )
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index],
                                ));
                          });
                        }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
