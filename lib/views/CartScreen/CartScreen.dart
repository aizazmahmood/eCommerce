import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/CartController.dart';
import 'package:pointofsale/views/CartScreen/ShippingScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          textColor: whiteColor,
          title: "Proceed to Shipping",
          onPress: () {
            Get.to(() => const ShippingDetails());
          },
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semiBold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['image']}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['quantity']})"
                                    .text
                                    .fontFamily(semiBold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['total_price']}"
                                .numCurrency
                                .text
                                .fontFamily(semiBold)
                                .size(14)
                                .color(redColor)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semiBold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalPrice.value}"
                            .numCurrency
                            .text
                            .fontFamily(semiBold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .width(context.screenWidth - 60)
                      .padding(const EdgeInsets.all(12))
                      .color(lightGolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  /*  SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: redColor,
                      textColor: whiteColor,
                      title: "Proceed to Shipping",
                      onPress: () {},
                    ),
                  ), */
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
