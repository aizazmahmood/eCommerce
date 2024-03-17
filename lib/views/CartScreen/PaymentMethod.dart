import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/CartController.dart';
import 'package:pointofsale/views/HomeScreen/Home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semiBold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place Order",
                  onPress: () async {
                    controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethod[controller.paymentIndex.value],
                        totalAmount: controller.totalPrice.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");

                    Get.offAll(const Home());
                  },
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: [
                ...List.generate(paymentMethod.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: redColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      value: true,
                                      onChanged: (value) {}),
                                )
                              : Container(),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: paymentMethod[index]
                                  .text
                                  .white
                                  .fontFamily(semiBold)
                                  .size(16)
                                  .make()),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
