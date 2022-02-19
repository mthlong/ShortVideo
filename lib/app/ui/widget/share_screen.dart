import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/report_page.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShareScreen extends StatefulWidget {
  final String id;

  const ShareScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 4.5,
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                  onTap: ()=> Get.to(()=>ReportPage(id: widget.id,)),
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Icon(
                    CupertinoIcons.flag,
                    color: AppColors.black,
                    size: 45,
                  ),
                  Height(space: 10),
                  Text(
                    "Báo cáo",
                    style: AppTextStyle.appTextStyle(
                        context, 16, AppColors.black, FontWeight.bold),
                  )
              ],
            ),
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.bookmark,
                  color: AppColors.black,
                  size: 45,
                ),
                Height(space: 10),
                Text(
                  "Ưa thích",
                  style: AppTextStyle.appTextStyle(
                      context, 16, AppColors.black, FontWeight.bold),
                )
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_down_circle,
                  color: AppColors.black,
                  size: 45,
                ),
                Height(space: 10),
                Text(
                  "Tải xuống",
                  style: AppTextStyle.appTextStyle(
                      context, 16, AppColors.black, FontWeight.bold),
                )
              ],
            )),
          ],
        ));
  }
}
