import 'dart:io';
import 'package:pointofsale/consts/consts.dart';
import 'package:pointofsale/controllers/ProfileController.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;

  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return backgroundWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['ImageUrl'] == "" && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : data['ImageUrl'] != "" && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['ImageUrl'],
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
                textColor: whiteColor,
                title: "Change",
                onPress: () {
                  controller.changeImage(context);
                }),
            const Divider(),
            20.heightBox,
            textField(
              controller: controller.nameController,
              title: name,
              hint: nameHint,
              isPass: false,
            ),
            10.heightBox,
            textField(
              controller: controller.oldPasswordController,
              title: oldPass,
              hint: passwordHint,
              isPass: true,
            ),
            10.heightBox,
            textField(
              controller: controller.newPasswordController,
              title: newPass,
              hint: passwordHint,
              isPass: true,
            ),
            20.heightBox,
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        textColor: whiteColor,
                        title: "Save",
                        onPress: () async {
                          controller.isLoading(true);

                          //if user doesn't change profile pic

                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['ImageUrl'];
                          }

                          //checking if the old password matches the database then allow user to create a new password

                          if (data['Password'] ==
                              controller.oldPasswordController.text) {
                            await controller.changeAuthPassword(
                              context: context,
                              email: data['Email'],
                              password: controller.oldPasswordController.text,
                              newPassword:
                                  controller.newPasswordController.text,
                            );

                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newPasswordController.text,
                            );
                            VxToast.show(context, msg: "Updated Successfully!");
                          } else {
                            VxToast.show(context, msg: "Wrong Password!");
                            controller.isLoading(false);
                          }
                        }),
                  ),
          ],
        )
            .box
            .white
            .rounded
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
