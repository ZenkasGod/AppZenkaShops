import 'package:appshopthoitran/Const/const.dart';

Widget ourButton({VoidCallback? onPress, Color? color, Color? textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: Text(
      title ?? "",
      style: TextStyle(
        color: textColor,
        fontFamily: bold,
      ),
    ),
  );
}

