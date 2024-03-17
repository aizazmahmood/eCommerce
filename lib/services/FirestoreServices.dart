import 'package:pointofsale/consts/consts.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return fireStore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category

  static getProducts(category) {
    return fireStore
        .collection(usersCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get products according to subcategory
  static getSubCategoryProducts({title}){
    return fireStore
        .collection(usersCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }


  //get cart

  static getCart(uid) {
    return fireStore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete document

  static deleteDocument(docId) {
    return fireStore.collection(cartCollection).doc(docId).delete();
  }

  //get all chats messages

  static getChatMessages(docId) {
    return fireStore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //get all orders

  static getAllOrders() {
    return fireStore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get all wishlist
  static getWishlists() {
    return fireStore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!)
        .snapshots();
  }

  // get all messages
  static getAllMessages() {
    return fireStore
        .collection(chatsCollection)
        .where('from_id', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get total counts
  static getCounts() async {
    var res = await Future.wait([
      fireStore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  //all products
  static allProducts() {
    return fireStore.collection(productCollection).snapshots();
  }

  //get featured products
  static getFeaturedProducts() {
    return fireStore
        .collection(productCollection)
        .where('isFeatured', isEqualTo: true)
        .snapshots();
  }

  //search method
  static searchProducts({title}) {
    return fireStore.collection(productCollection).get();
  }
}
