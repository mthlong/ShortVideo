import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:flutter/material.dart';

import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool passwordVisible = true;
  bool isMatch = false;
  final TextEditingController _textFieldController =
  TextEditingController();
  final TextEditingController _textEditingControllerPass = TextEditingController();

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu",
            style:
            AppTextStyle.appTextStyleCaption(context, 20, FontWeight.w700)
                .copyWith(color: AppColors.black)),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Text("Hủy",
                style: AppTextStyle.appTextStyle(
                    context, 17, AppColors.grey, FontWeight.w200)),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if(isMatch) {
                profileController.changePassword(_textEditingControllerPass.text);
                _textEditingControllerPass.text = "";
                _textFieldController.text = "";
              } else {
                Get.snackbar('Lỗi', 'Bạn đã nhập mật khẩu không trùng! ');
              }
            },
            child: Center(
              child: Text("Lưu",
                  style: AppTextStyle.appTextStyle(
                      context,
                      17,
                      isMatch ? AppColors.redButton : AppColors.grey,
                      FontWeight.w200)),
            ),
          ),
          Width(space: 10)
        ],
      ),
      body: Column(
        children: [
          Height(space: 15),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              obscureText: passwordVisible,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(60),
              ],
              cursorColor: AppColors.redButton,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                hintText: "Nhập mật khẩu",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                labelText: "Mật khẩu",
                alignLabelWithHint: false,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          Height(space: 10),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingControllerPass,
              obscureText: passwordVisible,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                setState(() {
                  if(value == _textFieldController.text) {
                    isMatch = true;
                  } else {
                    isMatch = false;
                  }
                });
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(60),
              ],
              cursorColor: AppColors.redButton,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                hintText: "Nhập lại mật khẩu",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                labelText: "Xác nhận mật khẩu",
                alignLabelWithHint: false,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Mật khẩu bao gồm chuỗi kí tự liền nhau không dấu cách, dưới 12 kí tự", style: AppTextStyle.appTextStyle(context, 12, AppColors.grey, FontWeight.normal),))
        ],
      ),
    );
  }
}
