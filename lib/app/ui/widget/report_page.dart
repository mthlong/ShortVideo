import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/report_controller.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/thank_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class ReportPage extends StatefulWidget {
  final String id;

  const ReportPage({Key? key, required this.id}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _textFieldController = TextEditingController();

  void textTextField(String a) {
    _textFieldController.text = a;
  }

  ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    List<String> reason = [
      "Thông tin gây hiểu nhầm",
      "Tổ chức và cá nhân nguy hiểm",
      "Các hoạt động bất hợp pháp và hàng hóa bị kiểm soát",
      "Gian lận lừa đảo",
      "Vi phạm quyền sở hữu",
      "Nội dung bạo lực phản cảm",
      "Nội dung khiêu dâm khỏa thân"
    ];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Báo cáo",
            style:
                AppTextStyle.appTextStyleCaption(context, 20, FontWeight.normal)
                    .copyWith(color: AppColors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {Get.back();Get.back();},
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Icon(
                  CupertinoIcons.clear,
                  color: AppColors.black,
                  size: 20,
                ),
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  itemCount: reason.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {
                          textTextField(reason[index]);
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                reason[index],
                                style: AppTextStyle.appTextStyle(context, 12,
                                    AppColors.black, FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    onChanged: (value) {},
                    cursorColor: AppColors.redButton,
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      suffixIcon: _textFieldController.text.isEmpty
                          ? null
                          : InkWell(
                              onTap: () {
                                _textFieldController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: AppColors.grey,
                              ),
                            ),
                      hintText: "Nội dung",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Nội dung",
                      alignLabelWithHint: false,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Positioned(
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      // reportController.sendReport(_textFieldController.text,
                      //     authController.user.uid, widget.id);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThankDialog(key: null,);
                          });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.redButton),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Text(
                            "Gửi",
                            style: AppTextStyle.appTextStyle(
                                context, 15, AppColors.white, FontWeight.bold),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
