import 'dart:io';
import 'package:appshopthoitran/Const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class ProfileControler extends GetxController {

  var profileImgPath = ''.obs;
  var profileImageLink = '';

  //textfield
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  var isloading = false.obs;

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      print('Error picking image: $e');
      VxToast.show(context, msg: e.toString());
    }
  }


  uploadProfileImage() async {
    try {
      var filename = basename(profileImgPath.value);
      var destination = 'images/${currentUser!.uid}/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));
      profileImageLink = await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      print('Error details: ${e.toString()}');
      // Handle the error, show a toast, or perform other error-handling actions.
    }
  }


  updateProfile({name, password, imgUrl}) async {
    try {
      isloading(true);
      var store = firestore.collection(usersCollection).doc(currentUser!.uid);
      await store.set(
        {'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true),
      );
    } finally {
      isloading(false);
    }
  }

  changeAuthPassword({email, password,newpassword}) async{
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());
    });
  }

}