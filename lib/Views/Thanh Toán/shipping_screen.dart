import 'package:appshopthoitran/Controller/cart_controller.dart';
import 'package:appshopthoitran/Views/Thanh%20To%C3%A1n/payment_method.dart';
import 'package:appshopthoitran/Views/widgets_common/custom_textfiled.dart';
import 'package:appshopthoitran/Views/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../Const/const.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Thông tin đơn hàng"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              onPress: () {
                if (controller.addressController.text.length > 10) {
                  Get.to(() => const PaymentMethods());
                } else {
                  VxToast.show(context, msg: "Vui lòng điền thông tin của bạn");
                }
              },
              color: redColor,
              textColor: whiteColor,
              title: "Tiếp tục")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextFiled(
                  hint: "Địa chỉ giao hàng",
                  isPass: false,
                  title: "Địa chỉ",
                  controller: controller.addressController),
              customTextFiled(
                  hint: "Phường",
                  isPass: false,
                  title: "Phường",
                  controller: controller.wardController),
              customTextFiled(
                  hint: "Quận",
                  isPass: false,
                  title: "Quận",
                  controller: controller.stateController),
              customTextFiled(
                  hint: "Thành phố",
                  isPass: false,
                  title: "Thành phố",
                  controller: controller.cityController),
              customTextFiled(
                  hint: "Mã bưu điện",
                  isPass: false,
                  title: "Mã bưu điện",
                  controller: controller.postalcodeController),
              customTextFiled(
                  hint: "Phone",
                  isPass: false,
                  title: "Số điện thoại",
                  controller: controller.phoneController),
            ],
          ),
        ),
      ),
    );
  }
}
