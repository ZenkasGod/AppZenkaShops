import 'package:appshopthoitran/Const/list.dart';
import 'package:appshopthoitran/Controller/auth_controller.dart';
import 'package:appshopthoitran/Views/M%C3%A0n%20h%C3%ACnh%20x%C3%A1c%20th%E1%BB%B1c/%C4%91%C4%83ng%20k%C3%AD.dart';
import '../../Const/const.dart';
import 'package:get/get.dart';
import '../Trang Chủ/Home.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfiled.dart';
import '../widgets_common/logoshop.dart';
import '../widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            logoshopWidget(),
            10.heightBox,
            "Đăng nhập để vào $appname"
                .text
                .white
                .fontFamily(bold)
                .white
                .size(17)
                .make(),
            15.heightBox,
            Column(
                children: [
                  customTextFiled(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  customTextFiled(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  ourButton(
                      color: redColor,
                      title: login,
                      textColor: whiteColor,
                      onPress: () async {
                        await controller.loginMethod(context: context).then((value){
                          if(value != null){
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          }
                        });

                      }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                          color: lightGolden,
                          title: signup,
                          textColor: redColor,
                          onPress: () {
                                Get.to(() => const SignupScreen());
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
          ],
        ),
      ),
    ));
  }
}
