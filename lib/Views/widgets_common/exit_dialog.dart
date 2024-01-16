import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Views/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Xác nhận".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Bạn có chắc chắn muốn thoát không?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor, onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor,title: "Đồng ý"),
            ourButton(color: redColor, onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "Không"),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}