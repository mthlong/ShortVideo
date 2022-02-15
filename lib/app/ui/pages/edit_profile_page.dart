import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/change_bio.dart';
import 'package:final_app/app/ui/widget/change_id_page.dart';
import 'package:final_app/app/ui/widget/change_name_page.dart';
import 'package:final_app/app/ui/widget/change_password_page.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _selectedImage;

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cắt ảnh',
              toolbarColor: AppColors.redButton,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            title: 'Cắt ảnh',
          ));
      setState(() {
        _selectedImage = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sửa hồ sơ",
          style:
              AppTextStyle.appTextStyleCaption(context, 20, FontWeight.normal)
                  .copyWith(color: AppColors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: (){Get.back();},
            child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _viewAvatar(context),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Thay đổi ảnh",
              style:
                  AppTextStyle.appTextStyle(context, 14, AppColors.black, null),
            ),
          ),
          Height(space: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text("Giới thiệu về bạn",
                  style: AppTextStyle.appTextStyle(
                      context, 12, AppColors.grey, FontWeight.bold)),
              Height(space: 10),
              //Đổi tên
              InkWell(
                onTap: () {Get.to(() => ChangeName());},
                child: Row(
                  children: [
                    Text(
                      "Tên",
                      style: AppTextStyle.appTextStyle(
                          context, 15, AppColors.black, null),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "Tên người dùng",
                          style: AppTextStyle.appTextStyle(
                              context, 15, AppColors.black, null),
                        ),
                        Width(space: 5),
                        Icon(Icons.arrow_forward_ios, size: 15, color: AppColors.black,)
                      ],
                    ),
                  ],
                ),
              ),
              Height(space: 25),
              //Đổi ID
              InkWell(
                onTap: () {Get.to(() => ChangeId());},
                child: Row(
                  children: [
                    Text(
                      "ID",
                      style: AppTextStyle.appTextStyle(
                          context, 15, AppColors.black, null),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "@username",
                          style: AppTextStyle.appTextStyle(
                              context, 15, AppColors.black, null),
                        ),
                        Width(space: 5),
                        Icon(Icons.arrow_forward_ios, size: 15, color: AppColors.black,)
                      ],
                    ),
                  ],
                ),
              ),
              Height(space: 25),
              //Đổi tiểu sử
              InkWell(
                onTap: () {Get.to(() => ChangeBio());},
                child: Row(
                  children: [
                    Text(
                      "Tiểu sử",
                      style: AppTextStyle.appTextStyle(
                          context, 15, AppColors.black, null),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "Thêm tiểu sử vào hồ sơ của bạn",
                          style: AppTextStyle.appTextStyle(
                              context, 15, AppColors.grey, null),
                        ),
                        Width(space: 5),
                        Icon(Icons.arrow_forward_ios, size: 15, color: AppColors.black,)
                      ],
                    ),
                  ],
                ),
              ),
              Height(space: 25),
              //Đổi mật khẩu
              InkWell(

                onTap: () {Get.to(() => ChangePass());},
                child: Row(
                  children: [
                    Text(
                      "Đổi mật khẩu",
                      style: AppTextStyle.appTextStyle(
                          context, 15, AppColors.black, null),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "***********",
                          style: AppTextStyle.appTextStyle(
                              context, 15, AppColors.black, null),
                        ),
                        Width(space: 5),
                        Icon(Icons.arrow_forward_ios, size: 15, color: AppColors.black,)
                      ],
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Container _viewAvatar(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30),
        width: 120,
        height: 120,
        child: Stack(children: <Widget>[
          Container(
            child: Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ))
                        : CachedNetworkImage(
                            width: 120,
                            height: 120,
                            imageUrl: 'https://picsum.photos/seed/5/200',
                            imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover))),
                            placeholder: (context, url) => GFShimmer(
                                  child: Container(
                                      color: AppColors.white.withOpacity(0.5),
                                      height: 120,
                                      width: 120),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error)),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 120,
                      height: 120,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 120,
            child: InkWell(
              onTap: () async => {await pickImage()},
              child: Icon(
                Icons.camera_enhance_outlined,
                size: 45,
                color: AppColors.white.withOpacity(0.75),
              ),
            ),
          )
        ]));
  }
}
