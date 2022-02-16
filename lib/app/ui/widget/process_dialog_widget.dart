import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_compress/video_compress.dart';

class ProcessDialogWidget extends StatefulWidget {
  final RxDouble? progress;
  ProcessDialogWidget({Key? key, required this.progress}) : super(key: key);

  @override
  State<ProcessDialogWidget> createState() => _ProcessDialogWidgetState();
}

class _ProcessDialogWidgetState extends State<ProcessDialogWidget> {

  late double progress;
  @override
  void initState() {
    progress = widget.progress!.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final percent = progress * 100;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Đang tải lên", style: AppTextStyle.appTextStyle(context, 18, AppColors.black, FontWeight.bold),),
        Obx(()=>CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: widget.progress!.value,
          center: Text(
            "$percent %",
            style: AppTextStyle.appTextStyle(context, 14, AppColors.black, FontWeight.bold),
          ),
          footer: const Text(
            "Tải lên hoàn tất",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: AppColors.redButton,
        )),
      ],
    );

  }
}
