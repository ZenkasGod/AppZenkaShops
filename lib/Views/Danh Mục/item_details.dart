import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Controller/product_controller.dart';
import 'package:appshopthoitran/Views/chat_screen/chat_screen.dart';
import 'package:appshopthoitran/Views/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../Const/list.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share, color: darkFontGrey)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id,context);
                    } else {
                      controller.addToWishlist(data.id,context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    10.heightBox,
                    "${data['p_price']}.000₫"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Người bán".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.message_rounded, color: darkFontGrey),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        }),
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Màu sắc: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index])
                                              .withOpacity(1.0))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()
                                          .onTap(() {
                                        controller.changedColorIndex(index);
                                      }),
                                      Visibility(
                                        visible: index ==
                                            controller.colorIndex.value,
                                        child: const Icon(Icons.done,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //Số lượng sản phẩm

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Số lượng: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantily.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quality']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quality']} có sẵn)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //Total now
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Tổng tiền: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              "${controller.totalPrice.value}.000₫"
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    // Mô tả
                    10.heightBox,
                    "Mô tả sản phẩm"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //Button Section
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonsList.length,
                        (index) => ListTile(
                          title: itemDetailButtonsList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    20.heightBox,
                    //Product may like
                    productlike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "13.999.000"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    10.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    )
                  ],
                  // here our button Ui
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if(controller.quantily.value > 0){
                      controller.addtoCart(
                          color: data['p_colors'][controller.colorIndex.value],
                          context: context,
                          vendorID: data['vendor_id'],
                          img: data['p_imgs'][0],
                          qty: controller.quantily.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Đã được thêm giỏ hàng");
                    }else{
                      VxToast.show(context, msg: "Số lượng của bạn không được 0 tối thiểu là 1");
                    }
                  },
                  textColor: whiteColor,
                  title: "Thêm giỏ hàng"),
            ),
          ],
        ),
      ),
    );
  }
}
