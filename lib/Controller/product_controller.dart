import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantily = 1.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var subCat = <String>[].obs;

  var isFav = false.obs;

  getSubCategories(title) async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) => element.name == title).toList();

    subCat.clear(); // Clear existing elements before adding new ones

    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        subCat.add(e);
      }
    } else {
      // Handle the case when no category with the specified title is found
      print('No category found with title: $title');
    }
  }

  changedColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantily.value < totalQuantity) {
      quantily++;
    }
  }

  decreaseQuantity() {
    if (quantily.value > 1) {
      quantily.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantily.value;
  }

  addtoCart({title, img, sellername, color, qty, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id' : vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantily.value = 0;
    colorIndex.value = 0;
    isFav.value = false;
  }

  addToWishlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist' : FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Thêm yêu thích");
  }

  removeFromWishlist(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Xóa yêu thích");
  }

  checkIffav(data) async {
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
  }
}
