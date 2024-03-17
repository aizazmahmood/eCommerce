import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;


//collections
const usersCollection = "users";
const productCollection = "Products";
const cartCollection = "Cart";
const chatsCollection = "Chats";
const messagesCollection = "Messages";
const ordersCollection = "orders";