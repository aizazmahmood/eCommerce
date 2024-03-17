import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/auth_controllers.dart';
import 'package:pointofsale/views/HomeScreen/Home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isCheck = false;
  var controller = Get.put(AuthController());

  //text Controllers

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogo(),
              10.heightBox,
              "Sign Up to $appname".text.fontFamily(bold).white.size(20).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    textField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false,
                    ),
                    textField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false,
                    ),
                    textField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true,
                    ),
                    textField(
                      title: retypePassword,
                      hint: passwordHint,
                      controller: retypePasswordController,
                      isPass: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPass.text.make(),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue!;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: termsConditions,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            textColor: whiteColor,
                            title: signup,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isLoading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then(
                                    (value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                      );
                                    },
                                  ).then((value) => {
                                            VxToast.show(context,
                                                msg: loggedIn),
                                            Get.offAll(() => const Home()),
                                          });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isLoading(false);
                                }
                              }
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    //wrapping the text into gesture detector of velocity x
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
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
    );
  }
}
