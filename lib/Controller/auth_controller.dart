import 'package:appshopthoitran/Const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {

  //textcontroller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



// login
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Sigup medthod đăng kí tài khoản
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Phương thức Lưu dữ liệu
  storeUsersData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set(
        {'name': name,
          'password': password,
          'email': email,
          'imageUrl': '' ,
          'id': currentUser!.uid,
          'cart_count':'00',
          'order_count':'00',
          'wishlist_count':'00'});
  }

  // Phương thức đăng xuất tài khoản
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}

