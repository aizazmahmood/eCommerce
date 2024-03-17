import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/views/OrdersScreen/Components/OrderPlacedDetails.dart';
import 'package:pointofsale/views/OrdersScreen/Components/OrderStatus.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semiBold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Order Placed",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Order Confirmed",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Colors.yellow,
                  icon: icDelivery,
                  title: "Order on Delivery",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Order Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method",
                  ),
                  orderPlacedDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method",
                  ),
                  orderPlacedDetails(
                    d1: "UnPaid",
                    d2: "Processing",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semiBold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_postalCode']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "Pakistan".text.make(),
                            "${data['order_by_phone']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semiBold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.white.outerShadowMd.make(),
              const Divider(),
              10.heightBox,
              "Ordered Products"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semiBold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlacedDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['total_price'],
                          d1: "${data['orders'][index]['quantity']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(data['orders'][index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ],
              )
                  .box
                  .white
                  .outerShadowMd
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
