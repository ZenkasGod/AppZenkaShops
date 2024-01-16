import 'package:appshopthoitran/Const/const.dart';

Widget orderPlaceDetails({title1, title2, d1,d2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
       SizedBox(
         width : 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.color(redColor).fontFamily(semibold).make()
            ],
          ),
        )
      ],
    ),
  );
}