import 'dart:io'; // Import this line
import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyC58f3Vozq9LNuzp5Xhj2X1tbhRw_areCQ",
            appId: "1:383153093820:android:27985a3a3d67a0c25464b9",
            messagingSenderId: "383153093820",
            projectId: "zenkashop-2d187",
          )
        : null,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZenkaShop',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
