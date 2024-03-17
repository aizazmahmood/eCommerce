import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointofsale/consts/consts.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semiBold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Nothing in Wishlist yet"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['p_images'][0]}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .fontFamily(semiBold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index][' p_price']}"
                              .numCurrency
                              .text
                              .fontFamily(semiBold)
                              .size(14)
                              .color(redColor)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite_outlined,
                            color: redColor,
                          ).onTap(() async {
                            await fireStore
                                .collection(productCollection)
                                .doc(data[index].id)
                                .set(
                              {
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid])
                              },
                              SetOptions(merge: true),
                            );
                          }),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
