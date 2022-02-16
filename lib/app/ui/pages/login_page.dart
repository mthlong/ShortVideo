import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/auth_controller.dart';
import 'package:final_app/app/ui/pages/signup_page.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  AuthController controller = Get.put(AuthController());
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
              _buildLogo(),
              _buidTextLogin(context),
              _buidTextFeildEmail(),
              _buildTextFeildPass(),
              _buildCheckBoxAndText(context),
              _buildTwoButtons(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "hoặc",
                  style: AppTextStyle.appTextStyle(
                      context, 18, AppColors.grey, FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "đăng nhập bằng",
                  style: AppTextStyle.appTextStyle(
                      context, 18, AppColors.grey, FontWeight.normal),
                ),
              ),
              _buildLoginPhoneButton()
            ],
          ),
        );
  }

  Container _buildLoginPhoneButton() {
    return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.phone_solid,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            );
  }

  Row _buildTwoButtons(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(()=>Stack(
                  children: [
                    Visibility(
                      visible: !controller.isLoading.value ? true : false,
                      child: InkWell(

                        onTap: () {
                          authController.loginUser(_emailController.text, _passwordController.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.redButton,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 14.0),
                            child: Text(
                              "Đăng nhập",
                              style: AppTextStyle.appTextStyle(context, 18,
                                  AppColors.white, FontWeight.normal),
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
                            color: AppColors.redButton),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40.0),
                          child: Image.asset(
                            'assets/images/loading_button.gif',
                            width: 25,
                            height: 25,)
                        ),
                      ),
                    ),
                  ],
                )),
                Width(space: 30),
                InkWell(
                  onTap: () {
                    Get.to(SignupPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1.5, color: AppColors.redButton)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0),
                      child: Text(
                        " Đăng ký ",
                        style: AppTextStyle.appTextStyle(context, 18,
                            AppColors.redButton, FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            );
  }

  Padding _buildCheckBoxAndText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 80),
      child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: isChecked
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2.2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Icon(
                                  Icons.check,
                                  size: 22.0,
                                  color: Colors.grey,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2.2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Icon(
                                  Icons.check,
                                  size: 22.0,
                                  color: Colors.white,
                                ),
                              )),
                  ),
                  Text(
                    "Lưu thông tin đăng nhập",
                    style: AppTextStyle.appTextStyle(
                        context, 16, AppColors.grey, FontWeight.normal),
                  )
                ],
              ),
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
                            width: 1,
                            color: AppColors.grey.withOpacity(0.9)),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: 1.5),
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
                            width: 1,
                            color: AppColors.grey.withOpacity(0.9)),
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

  Padding _buidTextLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
                children: [
                  Text(
                    "Đăng nhập",
                    style: AppTextStyle.appTextStyle(
                        context, 30, AppColors.black, FontWeight.normal),
                  ),
                ],
              ),
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
}
