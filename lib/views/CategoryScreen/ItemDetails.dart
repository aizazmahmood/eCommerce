import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/ProductController.dart';
import 'package:pointofsale/views/chat_screen/ChatScreen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  color: controller.isFav.value ? redColor : darkFontGrey,
                  Icons.favorite_outlined,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data['p_images'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_images'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      //title and details section
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semiBold)
                          .make(),
                      10.heightBox,
                      //rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textFieldGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .size(18)
                          .fontFamily(bold)
                          .make(),

                      10.heightBox,

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Seller".text.white.fontFamily(semiBold).make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .fontFamily(semiBold)
                                    .color(darkFontGrey)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => const ChatScreen(),
                              arguments: [data['p_seller'], data['seller_id']],
                            );
                          }),
                        ],
                      )
                          .box
                          .height(60)
                          .color(textFieldGrey)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .make(),

                      //color section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Color".text.color(textFieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    ...List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .roundedFull
                                                    .color(Color(
                                                            data['p_colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6))
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .color(textFieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              price:
                                                  int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      controller.quantity.value.text
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              totalQuantity: int.parse(
                                                  data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              price:
                                                  int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      10.widthBox,
                                      "(${data['p_quantity']} available)"
                                          .text
                                          .color(textFieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),

                                //total row
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Total:"
                                          .text
                                          .color(textFieldGrey)
                                          .make(),
                                    ),
                                    "${controller.totalPrice.value}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //description section
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semiBold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .color(darkFontGrey)
                          .make(),

                      //buttons section
                      10.heightBox,

                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...List.generate(
                            itemDetailsButton.length,
                            (index) => ListTile(
                              title: itemDetailsButton[index]
                                  .text
                                  .fontFamily(semiBold)
                                  .color(darkFontGrey)
                                  .make(),
                              trailing: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                      20.heightBox,

                      //products you may like

                      productsYouMay.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              6,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  "Laptop Core i7"
                                      .text
                                      .fontFamily(semiBold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "\$600"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(8))
                                  .make(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {
                  if (controller.quantity.value > 0) {
                    controller.addToCart(
                      context: context,
                      color: data['p_colors'][controller.colorIndex.value],
                      image: data['p_images'][0],
                      sellerId: data['seller_id'],
                      quantity: controller.quantity.value,
                      sellerName: data['p_seller'],
                      title: data['p_name'],
                      tPrice: controller.totalPrice.value,
                    );
                    VxToast.show(context, msg: "Added to Cart!");
                  } else {
                    VxToast.show(context, msg: "Quantity can't be 0");
                  }
                },
                textColor: whiteColor,
                title: "Add to Cart",
              ),
            )
          ],
        ),
      ),
    );
  }
}
