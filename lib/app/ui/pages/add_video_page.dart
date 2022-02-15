import 'package:camera/camera.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.2);
  CameraController _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _cameraController.initialize().then((value) {
      if(!mounted) return;
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          if(_cameraController.value.isInitialized)_buildCameraPreview(),
          Spacer(),
          Container(
            height: 90,
            color: AppColors.black,
            child: _buildCameraTemplateSelector(),
          )
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    final style = AppTextStyle.appTextStyle(
        context, 15, AppColors.white, FontWeight.bold);
    return Container(
      height: MediaQuery.of(context).size.height - 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            alignment: Alignment.center,
            child: CameraPreview(
              _cameraController),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 75, left: 24, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Icon(
                              CupertinoIcons.music_note_2,
                              color: AppColors.white,
                              size: 15,
                            ),
                          ),
                          Text(
                            "Chọn bài hát",
                            style: AppTextStyle.appTextStyle(
                                context, 12, AppColors.white, FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconWithText('flip', "Lật", style, 20),
                          _buildIconWithText('beauty', "Makeup", style, 20),
                          _buildIconWithText('filter', "Filter", style, 20),
                          _buildIconWithText('flash', "Flash", style, 20),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              _buildCameraTypeSelector(),
            ],
          ),


        ],
      ),
    );
  }

  Widget _buildCameraTypeSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconWithText(
              'effects',
              "Hiệu ứng",
              AppTextStyle.appTextStyle(
                  context, 11, AppColors.white, FontWeight.bold),
              40),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.redButton.withOpacity(0.65), width: 4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.redButton,
              radius: 30,
            ),
          ),
          _buildIconWithText(
              'upload',
              "Tải lên",
              AppTextStyle.appTextStyle(
                  context, 11, AppColors.white, FontWeight.bold),
              40),
        ],
      ),
    );
  }

  Widget _buildCameraTemplateSelector() {
    final List<String> postType = ["Máy ảnh", "MV"];
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 45,
          child: PageView.builder(
              controller: _pageController,
              itemCount: postType.length,
              onPageChanged: (int page) {
                setState(() {
                  _selectedTab = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Text(
                    postType[index],
                    style: AppTextStyle.appTextStyle(
                            context, 13, null, FontWeight.bold)
                        .copyWith(
                            color: _selectedTab == index
                                ? AppColors.white
                                : AppColors.grey),
                  ),
                );
              }),
        ),
        Container(
          width: 50,
          height: 45,
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 2.5,
          ),
        )
      ],
    );
  }

  Widget _buildIconWithText(
      String icon, String label, TextStyle style, double size) {
    return Column(
      children: [
        SvgPicture.asset('assets/images/$icon.svg'),
        Height(space: 5),
        Text(
          label,
          style: style,
        )
      ],
    );
  }
}
