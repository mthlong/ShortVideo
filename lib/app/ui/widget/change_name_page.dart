import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  bool _isChange = false;
  late String _enteredText = "";
  final TextEditingController _textFieldController = new TextEditingController();

  @override
  void initState() {
    _isChange = false;
    _textFieldController.text = "Tên người dùng";
    _enteredText = _textFieldController.text.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "Tên",
          style:
          AppTextStyle.appTextStyleCaption(context, 20, FontWeight.w700)
              .copyWith(color: AppColors.black)),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Text("Hủy", style:
            AppTextStyle.appTextStyle(context, 17,AppColors.grey,FontWeight.w200)),
          ),
        ),
        actions: [
          Center(
            child: Text("Lưu", style:
            AppTextStyle.appTextStyle(context, 17, _isChange ? AppColors.redButton : AppColors.grey,FontWeight.w200)),
          ), 
          Width(space: 10)
        ],
      ),
      body: Column(children: [
        Height(space: 15),
        Container(
          margin: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                if(_textFieldController.text == "Tên người dùng"){
                  _isChange = false;
                } else {
                  _isChange = true;
                }
                _enteredText = value;
              });
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
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
                child: Icon(Icons.clear, color: AppColors.grey,),
              ),
              hintText: "Nhập tên người dùng mới",
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              labelText: "Tên",
              alignLabelWithHint: false,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ),
        Text('${_enteredText.length.toString()} /30', style: AppTextStyle.appTextStyle(context, 17,AppColors.grey,FontWeight.w200))
      ],),
    );
  }
}
