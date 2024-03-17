import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/models/CategoryModel.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var subcat = [];

  var isFav = false.obs;

  getSubCategories({title}) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/CategoryModel.json");
    var decoded = categoryModelFromJson(data);

    var s =
    decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  //changing color

  changeColorIndex(index) {
    colorIndex = index;
  }

//quantity increase and decrease method

  increaseQuantity({totalQuantity}) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  //total price method
  calculateTotalPrice({price}) {
    totalPrice.value = price * quantity.value;
  }

  //adding to cart method

  addToCart(
      {title, image, sellerName, color, quantity, tPrice,sellerId, context}) async {
    await fireStore.collection(cartCollection).doc().set({
      'title': title,
      'image': image,
      'sellerName': sellerName,
      'color': color,
      'quantity': quantity,
      'total_price': tPrice,
      'added_by': currentUser!.uid,
      'seller_id': sellerId,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  //adding to wishlist
  addToWishlist(docId,context) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishlist(docId,context) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    }
    else {
      isFav(false);
    }
  }

}
