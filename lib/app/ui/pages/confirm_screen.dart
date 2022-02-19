import 'dart:io';

import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/controllers/upload_video_controller.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;

  final String videoPath;

  ConfirmScreen({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  TextEditingController nameTextField = TextEditingController();
  TextEditingController songNameTextField = TextEditingController();
  TextEditingController hashTagTextField = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 1.3,
              child: VideoPlayer(controller),
            ),
            const Height(space: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: AppColors.white.withOpacity(0.95),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Height(space: 20),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {},
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        cursorColor: AppColors.redButton,
                        controller: nameTextField,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.clear,
                            color: AppColors.grey,
                          ),
                          hintText: "Nói bạn muốn nói gì về video này ?",
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                          ),
                          alignLabelWithHint: false,
                          labelText: 'Mô tả video của bạn',
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.black),
                          filled: true,
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Height(space: 10),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {},
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        cursorColor: AppColors.redButton,
                        controller: hashTagTextField,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                          ),
                          alignLabelWithHint: false,
                          labelText: 'Hashtag',
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Height(space: 10),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {},
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        cursorColor: AppColors.redButton,
                        controller: songNameTextField,
                        decoration: InputDecoration(
                          hintText: "Nhập tên bài hát",
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                          ),
                          alignLabelWithHint: false,
                          labelText: 'Tên bài hát',
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.black),
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Height(space: 10),
                    Obx(
                      () => Stack(
                        children: [
                          Visibility(
                              visible: uploadVideoController.isLoading.value
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Xin vui lòng chờ, video đang được tải lên... \nSau khi tải lên hoàn tất bạn sẽ được chuyển về trang trước :D ",
                                      style: AppTextStyle.appTextStyle(
                                          context,
                                          14,
                                          AppColors.black,
                                          FontWeight.normal),
                                    ),
                                  ),
                                  CircularPercentIndicator(
                                    radius: 45.0,
                                    lineWidth: 4.0,
                                    animation: true,
                                    animationDuration: 8500,
                                    percent: 1.0,
                                    progressColor: AppColors.redButton,
                                  )
                                ],
                              )),
                          Visibility(
                            visible: !uploadVideoController.isLoading.value
                                ? true
                                : false,
                            child: InkWell(
                              onTap: () {
                                uploadVideoController.uploadVideo(
                                    nameTextField.text,
                                    hashTagTextField.text,
                                    songNameTextField.text,
                                    widget.videoPath);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.redButton,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 30.0),
                                  child: Text(
                                    "Chia sẻ",
                                    style: AppTextStyle.appTextStyle(context,
                                        20, AppColors.white, FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
