import 'package:appshopthoitran/Controller/auth_controller.dart';
import 'package:appshopthoitran/Views/widgets_common/logoshop.dart';

import 'package:get/get.dart';
import '../../Const/const.dart';
import '../Trang Chủ/Home.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfiled.dart';
import '../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text Controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var paswordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            logoshopWidget(),
            10.heightBox,
            "Tham gia với $appname chúng tôi "
                .text
                .white
                .fontFamily(bold)
                .white
                .size(17)
                .make(),
            15.heightBox,
            Column(
                children: [
                  customTextFiled(hint: nameHint, title: name, controller: nameController, isPass: false),
                  customTextFiled(hint: emailHint, title: email, controller: emailController, isPass: false),
                  customTextFiled(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                  customTextFiled(hint: passwordHint, title: retypePassword, controller: paswordRetypeController, isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                        TextSpan(
                            text: "Tôi đồng ý với ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: termAndCond,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ))
                      ])))
                    ],
                  ),
                  5.heightBox,
                  ourButton(
                          color: isCheck == true ? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              try {
                                await controller.signupMethod(
                                    context: context, email: emailController.text, password: passwordController.text).then((value) {
                                  return controller.storeUsersData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      }),
                    ],
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
