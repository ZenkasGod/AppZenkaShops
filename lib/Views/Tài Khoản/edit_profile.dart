import 'dart:io';
import 'package:appshopthoitran/Controller/profile_controller.dart';
import 'package:appshopthoitran/Views/widgets_common/bg_widget.dart';
import 'package:appshopthoitran/Views/widgets_common/custom_textfiled.dart';
import 'package:appshopthoitran/Views/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../Const/const.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileControler>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile, width: 130, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Cập nhật"),
            const Divider(),
            20.heightBox,
            customTextFiled(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextFiled(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextFiled(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          if (controller.profileImgPath.value.isEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          if (data['password'] == controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword:  controller.newpassController.text
                            );
                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Đã cập nhật thành công");
                          }else{
                            VxToast.show(context, msg: "Mật khẩu cũ nhập sai , vui lòng nhập lại");

                          }
                        },
                        textColor: whiteColor,
                        title: "Lưu lại")),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(bottom: 120, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
