import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:final_app/app/ui/widget/my_list_video.dart';
import 'package:final_app/app/ui/widget/my_love_list_video.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:final_app/app/ui/widget/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: _buildAppBar(context),
              body: Column(
                children: [
                  Height(space: 5),
                  //avatar
                  _buildAvatar(controller),
                  Height(space: 10),
                  //Ten
                  Obx(
                    () => controller.user.isEmpty
                        ? GFShimmer(
                            child: Container(
                            color: AppColors.white.withOpacity(0.2),
                            height: 30,
                            width: 100,
                          ))
                        : Container(
                            width: 200,
                            height: 30,
                            child: Center(
                              child: Text(
                                "@" + controller.user['name'],
                                style: AppTextStyle.appTextStyle(context, 15,
                                    AppColors.black, FontWeight.normal),
                              ),
                            ),
                          ),
                  ),
                  Height(space: 15),
                  _buildInfo(controller, context),
                  Height(space: 15),
                  //button
                  _buildButton(controller, context),
                  Height(space: 10),
                  //bio
                  Obx(
                    () => controller.user.isEmpty
                        ? GFShimmer(
                            child: Container(
                            color: AppColors.white.withOpacity(0.2),
                            height: 30,
                            width: MediaQuery.of(context).size.width - 150,
                          ))
                        : Container(
                            color: AppColors.white.withOpacity(0.5),
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              controller.user['bio'],
                              maxLines: 3,
                              style: AppTextStyle.appTextStyle(context, 12,
                                  AppColors.grey, FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  Height(space: 10),
                  TabBar(tabs: [
                    Tab(
                      icon: Icon(Icons.grid_3x3, color: AppColors.black),
                    ),
                    Tab(
                      icon: Icon(Icons.favorite, color: AppColors.black),
                    ),
                  ]),
                  Expanded(
                      child: TabBarView(
                    children: [
                      MyVideoList(
                        controller: controller,
                        thumbnail: controller.user['thumbnails'],
                        videoUrl: controller.user['videoUrls'],
                        videoList: controller.user['videoList'],
                      ),
                      const EmptyView(
                        mess: "Không có video nào",
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }

  Stack _buildButton(ProfileController controller, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
            visible: widget.uid == authController.user.uid ? true : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Get.to(EditProfilePage(
                      bio: controller.user['bio'],
                      profileUrl: controller.user['profilePhoto'],
                      name: controller.user['name'])),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.8)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Sửa hồ sơ",
                        style: AppTextStyle.appTextStyle(
                            context, 15, AppColors.black, FontWeight.normal)),
                  ),
                ),
                Width(space: 10),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return YesNoDiaglog(
                              key: null,
                              label: "Bạn chắc chắn muốn ?",
                              decription: "Đăng xuất khỏi tài khoản",
                              eventYes: () {
                                authController.signOut();
                              });
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.8)),
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset(
                      'assets/images/logout.svg',
                      width: 17,
                      height: 17,
                    ),
                  ),
                )
              ],
            )),
        Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () => controller.followUser(),
              child: Visibility(
                  visible: widget.uid != authController.user.uid &&
                          !controller.user['isFollowing']
                      ? true
                      : false,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.redButton,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text("Theo dõi",
                          style: AppTextStyle.appTextStyle(
                              context, 15, AppColors.white, FontWeight.normal)),
                    ),
                  )),
            ),
            InkWell(
              onTap: () => {
                controller.followUser(),
              },
              child: Visibility(
                  visible: widget.uid != authController.user.uid &&
                          controller.user['isFollowing']
                      ? true
                      : false,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        "Hủy theo dõi",
                        style: AppTextStyle.appTextStyle(
                            context, 15, AppColors.black, FontWeight.normal),
                      ),
                    ),
                  )),
            )
          ],
        )
      ],
    );
  }

  Row _buildInfo(ProfileController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                controller.user.isEmpty
                    ? Text(
                        "0",
                        style: AppTextStyle.appTextStyle(
                            context, 21, AppColors.black, FontWeight.bold),
                      )
                    : Text(
                        controller.user['following'],
                        style: AppTextStyle.appTextStyle(
                            context, 21, AppColors.black, FontWeight.bold),
                      ),
                Text("Đang Follow",
                    style: AppTextStyle.appTextStyle(
                        context, 11, AppColors.grey, FontWeight.w300))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              controller.user.isEmpty
                  ? Text(
                      "0",
                      style: AppTextStyle.appTextStyle(
                          context, 21, AppColors.black, FontWeight.bold),
                    )
                  : Text(
                      controller.user['followers'],
                      style: AppTextStyle.appTextStyle(
                          context, 21, AppColors.black, FontWeight.bold),
                    ),
              Text("  Follower  ",
                  style: AppTextStyle.appTextStyle(
                      context, 11, AppColors.grey, FontWeight.w300))
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                controller.user.isEmpty
                    ? Text(
                        "0",
                        style: AppTextStyle.appTextStyle(
                            context, 21, AppColors.black, FontWeight.bold),
                      )
                    : Text(
                        controller.user['likes'],
                        style: AppTextStyle.appTextStyle(
                            context, 21, AppColors.black, FontWeight.bold),
                      ),
                Text("    Thích    ",
                    style: AppTextStyle.appTextStyle(
                        context, 11, AppColors.grey, FontWeight.w300))
              ],
            ),
          ),
        )
      ],
    );
  }

  ClipRRect _buildAvatar(ProfileController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Obx(() => controller.user.isEmpty
          ? GFShimmer(
              child: Container(
              color: AppColors.white.withOpacity(0.5),
              height: 110,
              width: 110,
            ))
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: controller.user['profilePhoto'],
              imageBuilder: (context, imageProvider) => Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => GFShimmer(
                      child: Container(
                    color: AppColors.white.withOpacity(0.5),
                    height: 110,
                    width: 110,
                  )),
              errorWidget: (context, url, error) => Icon(Icons.error))),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Trang cá nhân",
        style: AppTextStyle.appTextStyleCaption(context, 20, FontWeight.normal)
            .copyWith(color: AppColors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Icon(Icons.person_add, color: AppColors.black),
      actions: [
        Icon(
          Icons.menu,
          color: AppColors.black,
        )
      ],
    );
  }
}
