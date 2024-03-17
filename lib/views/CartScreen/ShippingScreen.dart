import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/CartController.dart';
import 'package:pointofsale/views/CartScreen/PaymentMethod.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semiBold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
          onPress: () {
            if (controller.addressController.text.length > 8 ||
                controller.cityController.text.length > 1 ||
                controller.stateController.text.length > 1 ||
                controller.postalCodeController.text.length > 1 ||
                controller.phoneController.text.length > 1) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            textField(
              title: "Address",
              hint: "Address",
              isPass: false,
              controller: controller.addressController,
            ),
            textField(
              title: "City",
              hint: "City",
              isPass: false,
              controller: controller.cityController,
            ),
            textField(
              title: "State/Province",
              hint: "State/Province",
              isPass: false,
              controller: controller.stateController,
            ),
            textField(
                title: "Postal Code",
                hint: "Postal Code",
                isPass: false,
                controller: controller.postalCodeController),
            textField(
                title: "Phone",
                hint: "Phone",
                isPass: false,
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
