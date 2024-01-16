import 'package:appshopthoitran/Const/const.dart';
import 'package:appshopthoitran/Controller/Home_Controller.dart';
import 'package:appshopthoitran/Views/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import '../Danh Mục/category_screen.dart';
import '../Thanh Toán/cart_screen.dart';
import '../Tài Khoản/profile_screen.dart';
import 'Home_Screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //Home Controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
        onWillPop: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => exitDialog(context));
          return false;
        },
        child: Scaffold(
          body: Column(
            children: [
              Obx(() => Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value))),
            ],
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              },
            ),
          ),
        ));
  }
}
