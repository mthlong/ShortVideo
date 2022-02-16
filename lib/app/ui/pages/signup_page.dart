import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/auth_controller.dart';
import 'package:final_app/app/ui/pages/login_page.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _selectedImage;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthController controller = Get.put(AuthController());

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cắt ảnh',
              toolbarColor: AppColors.redButton,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            title: 'Cắt ảnh',
          ));
      setState(() {
        _selectedImage = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pinkAccent,
            Colors.grey,
          ],
        )),
        child: Container(
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Height(space: 80),
          _buidTextLogin(context),
          _viewAvatar(context),
          _buidTextFeildUsername(),
          _buidTextFeildEmail(),
          _buildTextFeildPass(),
          Height(space: 50),
          _buildTwoButtons(context),
        ],
      ),
    );
  }

  Container _viewAvatar(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 30),
        width: 120,
        height: 120,
        child: Stack(children: <Widget>[
          Container(
            child: Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ))
                          : CircleAvatar(
                              child: Image.asset(
                                'assets/images/profile_login.jpg',
                                width: 120,
                                height: 120,
                              ),
                            )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 120,
                      height: 120,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 120,
            child: InkWell(
              onTap: () async => {await pickImage()},
              child: Icon(
                Icons.camera_enhance_outlined,
                size: 45,
                color: AppColors.white.withOpacity(0.75),
              ),
            ),
          )
        ]));
  }

  Row _buildTwoButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.to(LoginPage());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.redButton,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              child: Text(
                "Đăng nhập",
                style: AppTextStyle.appTextStyle(
                    context, 18, AppColors.white, FontWeight.normal),
              ),
            ),
          ),
        ),
        Width(space: 30),
        Obx(()=>Stack(
          children: [
            Visibility(
              visible: !controller.isLoading.value ? true : false,
              child: InkWell(
                onTap: () async {
                  await authController.registerUser(
                      _userNameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _selectedImage);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                      Border.all(width: 1.5, color: AppColors.redButton)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 14.0),
                    child: Text(
                      " Đăng ký ",
                      style: AppTextStyle.appTextStyle(
                          context, 18, AppColors.redButton, FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoading.value ? true : false,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.5, color: AppColors.redButton)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 40.0),
                  child: Image.asset(
                    'assets/images/loading_button.gif',
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Container _buildTextFeildPass() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _passwordController,
        cursorColor: AppColors.redButton,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: AppColors.grey.withOpacity(0.9)),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Icon(CupertinoIcons.lock,
                color: AppColors.grey.withOpacity(0.9)),
            hintText: "Nhập password",
            alignLabelWithHint: false,
            filled: true),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Container _buidTextFeildEmail() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _emailController,
        cursorColor: AppColors.redButton,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: AppColors.grey.withOpacity(0.9)),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            suffixIcon: Icon(CupertinoIcons.mail,
                color: AppColors.grey.withOpacity(0.9)),
            hintText: "Nhập email",
            alignLabelWithHint: false,
            filled: true),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Row _buidTextLogin(BuildContext context) {
    return Row(
      children: [
        Text(
          "Đăng ký",
          style: AppTextStyle.appTextStyle(
              context, 30, AppColors.black, FontWeight.normal),
        ),
      ],
    );
  }

  Padding _buildLogo() {
    return Padding(
        padding: EdgeInsets.only(top: 30, bottom: 50),
        child: Image.asset(
          'assets/images/logo.png',
          width: 130,
          height: 130,
        ));
  }

  Widget _buidTextFeildUsername() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            if (value.length == 10) {
              Fluttertoast.showToast(
                  gravity: ToastGravity.BOTTOM,
                  msg: 'UserName tối đa là 10 kí tự',
                  timeInSecForIosWeb: 1,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: AppColors.redButton,
                  textColor: AppColors.white);
            }
          });
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        controller: _userNameController,
        cursorColor: AppColors.redButton,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: AppColors.grey.withOpacity(0.9)),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Icon(CupertinoIcons.profile_circled,
                color: AppColors.grey.withOpacity(0.9)),
            hintText: "Nhập username",
            alignLabelWithHint: false,
            filled: true),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
