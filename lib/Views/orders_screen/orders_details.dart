import 'package:appshopthoitran/Views/orders_screen/components/order_place_details.dart';
import 'package:appshopthoitran/Views/orders_screen/components/order_status.dart';

import '../../Const/const.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Chi tiết đơn hàng"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Đặt hàng ",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Xác nhận đơn hàng",
                  showDone: data['order_comfirmed']),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "Đang giao hàng",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Hoàn tất đơn hàng",
                  showDone: data['order_delivered']),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Mã đơn hàng",
                      title2: "Hình thức vận chuyển"),
                  orderPlaceDetails(
                      d1: intl.DateFormat().add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Ngày đặt hàng",
                      title2: "Hình thức thanh toán"),
                  orderPlaceDetails(
                      d1: "Chưa thanh toán",
                      d2: "Order Placed",
                      title1: "Tình trạng thanh toán",
                      title2: "Tình trạng vận chuyển"),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Thông tin giao hàng"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                            "Tên Người nhận :"" ${data['order_by_name']}".text.make(),
                            "Email :"" ${data['order_by_email']}".text.make(),
                            "Địa chỉ :"" ${data['order_by_address']}".text.make(),
                            "Phường :"" ${data['order_by_ward']}".text.make(),
                            "Quận:"" ${data['order_by_state']}".text.make(),
                            "TP:"" ${data['order_by_city']}".text.make(),
                            "SĐT:"" ${data['order_by_phone']}".text.make(),
                            "Mã bưu điện:"" ${data['order_by_postalcode']}".text.make()
                            ],
                          ),
                          SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Tổng hóa đơn"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['total_amount']}"".000"
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                ],
                              ))
                        ],
                      ))
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Sản phẩm trong đơn hàng"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Có thể hoàn trả"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
