import 'dart:ffi';

import 'package:appshopthoitran/Controller/cart_controller.dart';
import 'package:appshopthoitran/Views/Thanh%20To%C3%A1n/shipping_screen.dart';
import 'package:appshopthoitran/Views/widgets_common/loading_indicator.dart';
import 'package:appshopthoitran/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Const/const.dart';
import '../widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
        color: redColor,
        onPress: () {
          Get.to(() => const ShippingDetails());
        },
        textColor: whiteColor,
        title: "Tiến hành thanh toán",
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "Thanh toán ".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Không có hóa đơn nào cần thanh toán".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                                "${data[index]['img']}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                            subtitle: "${data[index]['tprice']}.000₫"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing:
                                Icon(Icons.delete, color: redColor).onTap(() {
                              FirestorServices.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tổng tiền đơn hàng"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}.000₫"
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  //SizedBox(
                  //  width: context.screenWidth - 20,
                  // child: ourButton(
                  // color: redColor,
                  // onPress: () {},
                  // textColor: whiteColor,
                  // title: "Tiến hành thanh toán",
                  //),
                  //)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
