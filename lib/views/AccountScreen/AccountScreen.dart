import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/ProfileController.dart';
import 'package:pointofsale/controllers/auth_controllers.dart';
import 'package:pointofsale/views/AccountScreen/EditProfile.dart';
import 'package:pointofsale/views/AccountScreen/components/Details_Card.dart';
import 'package:pointofsale/views/OrdersScreen/OrdersScreen.dart';
import 'package:pointofsale/views/WishlistScreen/WishlistScreen.dart';
import 'package:pointofsale/views/auth_screen/auth_screen.dart';
import 'package:pointofsale/views/chat_screen/MessagingScreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return backgroundWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    //edit profile button

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        controller.nameController.text = data['Name'];
                        Get.to(() => EditProfile(data: data));
                      }),
                    ),

                    //user details section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['ImageUrl'] == ""
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['ImageUrl'],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['Name']}"
                                    .text
                                    .color(whiteColor)
                                    .fontFamily(semiBold)
                                    .make(),
                                "${data['Email']}"
                                    .text
                                    .color(whiteColor)
                                    .fontFamily(semiBold)
                                    .make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: whiteColor,
                              ),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signOutMethod(context);
                              Get.offAll(() => const AuthScreen());
                            },
                            child: logout.text
                                .color(whiteColor)
                                .fontFamily(semiBold)
                                .make(),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                    count: countData[0].toString(),
                                    title: "in your cart",
                                    width: context.screenWidth / 3.4),
                                detailsCard(
                                    count: countData[1].toString(),
                                    title: "in your wishlist",
                                    width: context.screenWidth / 3.4),
                                detailsCard(
                                    count: countData[2].toString(),
                                    title: "your orders",
                                    width: context.screenWidth / 3.4),
                              ],
                            );
                          }
                        },),

                    //buttons sections

                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 1:
                                Get.to(() => const WishListScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIcons[index],
                            width: 22,
                          ),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semiBold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .margin(const EdgeInsets.all(12))
                        .rounded
                        .shadowSm
                        .padding(
                          const EdgeInsets.symmetric(horizontal: 16),
                        )
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
