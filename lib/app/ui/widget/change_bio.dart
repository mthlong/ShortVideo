import 'package:flutter/material.dart';

import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChangeBio extends StatefulWidget {
  const ChangeBio({Key? key}) : super(key: key);

  @override
  State<ChangeBio> createState() => _ChangeBioState();
}

class _ChangeBioState extends State<ChangeBio> {
  String _enteredText = '';
  final TextEditingController _textFieldController =
  new TextEditingController();

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
          Center(
            child: Text("Lưu",
                style: AppTextStyle.appTextStyle(
                    context,
                    17,
                    AppColors.redButton,
                    FontWeight.w200)),
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
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(60),
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
                hintText: "Nhập giới thiệu",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                labelText: "Giới thiệu",
                alignLabelWithHint: false,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          Text('${_enteredText.length.toString()} /60',
              style: AppTextStyle.appTextStyle(
                  context, 15, AppColors.grey, FontWeight.w200)),
          Height(space: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
          )
        ],
      ),
    );
  }
}
