import 'package:appshopthoitran/Const/list.dart';
import 'package:appshopthoitran/Controller/auth_controller.dart';
import 'package:appshopthoitran/Controller/profile_controller.dart';
import 'package:appshopthoitran/Views/chat_screen/messaging.dart';
import 'package:appshopthoitran/Views/widgets_common/bg_widget.dart';
import 'package:appshopthoitran/Views/widgets_common/loading_indicator.dart';
import 'package:appshopthoitran/Views/wishlist_screen/wishlist_screen.dart';
import 'package:appshopthoitran/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../Const/const.dart';
import '../Màn hình xác thực/đăng nhập.dart';
import '../orders_screen/orders_screen.dart';
import 'components/details_cart.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileControler());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestorServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  //edit profile button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.edit, color: whiteColor))
                        .onTap(() {
                      controller.nameController.text = data['name'];

                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),

                  //users details section

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Image.asset(imgProfile, width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            5.heightBox,
                            "${data['email']}".text.white.make(),
                          ],
                        )),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                            color: whiteColor,
                          )),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make(),
                        )
                      ],
                    ),
                  ),

                  10.heightBox,
                  FutureBuilder(
                    future: FirestorServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(!snapshot.hasData){
                        return Center(child:loadingIndicator());
                      }else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "Giỏ hàng",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "Yêu thích",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[2].toString(),
                                title: "Đơn hàng",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }
                    },
                  ),

                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(color: lightGrey);
                    },
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => const WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => const MessagesScreen());
                            default:
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonsList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
