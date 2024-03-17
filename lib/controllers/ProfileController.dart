import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:pointofsale/consts/consts.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;

  var profileImageLink = '';

  var isLoading = false.obs;

  //textField controllers
  var nameController = TextEditingController();
  var newPasswordController = TextEditingController();
  var oldPasswordController = TextEditingController();

  //changing image method

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload pic method
  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = "images/${currentUser!.uid}/$filename";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  //updating document
  updateProfile({name, password, imgUrl}) async {
    var store = fireStore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'Name': name,
      'Password': password,
      'ImageUrl': imgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  //changing password in auth
  changeAuthPassword({email, password, newPassword,context}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword).catchError((error) {
        VxToast.show(context, msg: error.toString());
      });
    });
  }
}
