import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/views/CategoryScreen/ItemDetails.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title: title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Products Found!".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  children: [
                    ...filtered
                        .mapIndexed(
                          (currentValue, index) => Column(
                            children: [
                              Image.network(
                                filtered[index]['p_images'][0],
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              "${filtered[index]['p_name']}"
                                  .text
                                  .fontFamily(semiBold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filtered[index][' p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .outerShadowMd
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(
                            () {
                              Get.to(() => ItemDetails(
                                    title: "${filtered[index]['p_name']}",
                                    data: filtered[index],
                                  ));
                            },
                          ),
                        )
                        .toList(),
                  ],
                ),
              );
            }
          }),
    );
  }
}
