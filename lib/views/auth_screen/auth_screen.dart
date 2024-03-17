import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/auth_controllers.dart';

import 'package:pointofsale/views/HomeScreen/Home.dart';
import 'package:pointofsale/views/auth_screen/SignUp.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return backgroundWidget(
      child: SingleChildScrollView(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogo(),
                10.heightBox,
                "Log in to $appname"
                    .text
                    .fontFamily(bold)
                    .white
                    .size(20)
                    .make(),
                20.heightBox,
                Obx(
                  () => Column(
                    children: [
                      textField(
                        title: email,
                        hint: emailHint,
                        isPass: false,
                        controller: controller.emailController,
                      ),
                      textField(
                        title: password,
                        hint: passwordHint,
                        isPass: true,
                        controller: controller.passwordController,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: redColor,
                              textColor: whiteColor,
                              title: login,
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                          color: lightGolden,
                          textColor: redColor,
                          title: signup,
                          onPress: () {
                            Get.to(() => const SignUp());
                          }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      loginWith.text.make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 80)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
