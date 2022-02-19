import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:flutter/material.dart';

import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChangeId extends StatefulWidget {
  final String name;
  const ChangeId({Key? key, required this.name}) : super(key: key);

  @override
  State<ChangeId> createState() => _ChangeIdState();
}

class _ChangeIdState extends State<ChangeId> {
  bool _isChange = false;
  String _enteredText = '';
  final TextEditingController _textFieldController =
      new TextEditingController();

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    _textFieldController.text = widget.name;
    _enteredText = _textFieldController.text.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID",
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
          Center(
            child: InkWell(
              onTap: () {
                profileController.updateName(authController.user.uid, _textFieldController.text);
                _textFieldController.text = "";
                profileController.getUserData();
              } ,
              child: Text("Lưu",
                  style: AppTextStyle.appTextStyle(
                      context,
                      17,
                      _isChange ? AppColors.redButton : AppColors.grey,
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
              onChanged: (value) {
                setState(() {
                  if (_textFieldController.text == "username") {
                    _isChange = false;
                  } else {
                    _isChange = true;
                  }
                  _enteredText = value;
                });
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              cursorColor: AppColors.redButton,
              controller: _textFieldController,
              decoration: InputDecoration(
                suffixIcon: _textFieldController.text.isEmpty
                    ? null
                    : InkWell(
                        onTap: () {
                          _textFieldController.clear();
                          setState(() {
                            _enteredText = "";
                          });
                        },
                        child: Icon(
                          Icons.clear,
                          color: AppColors.grey,
                        ),
                      ),
                hintText: "Nhập id mới",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                labelText: "ID",
                alignLabelWithHint: false,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Text('${_enteredText.length.toString()} /10',
              style: AppTextStyle.appTextStyle(
                  context, 15, AppColors.grey, FontWeight.w200)),
          Height(space: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "ID của bạn sẽ bao gồm chữ cái, chữ số, dấu gạch dưới \nID của bạn sẽ là duy nhất và không thể bị trùng",
                    style: AppTextStyle.appTextStyle(
                        context, 13, AppColors.grey, FontWeight.w200)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
