import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/my_list_video.dart';
import 'package:final_app/app/ui/widget/my_love_list_video.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Height(space: 5),
            //avatar
            _buildAvatar(),
            Height(space: 10),
            //Ten
            Text(
              "@username",
              style: AppTextStyle.appTextStyle(
                  context, 15, AppColors.black, FontWeight.normal),
            ),
            Height(space: 15),
            _buildInfo(context),
            Height(space: 15),
            //button
            _buildButton(context),
            Height(space: 10),
            //bio
            Container(
              width: MediaQuery.of(context).size.width - 150,
              child: Text(
                "Chào mừng các bạn đến với app và đây là bio 🤣😊☺️",
                maxLines: 3,
                style: AppTextStyle.appTextStyle(
                    context, 12, AppColors.grey, FontWeight.normal),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
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
            Expanded(child: TabBarView(children: [
              MyVideoList(),
              MyLoveVideoList()
            ],))
          ],
        ),
      ),
    );
  }

  Row _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.to(EditProfilePage()),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey.withOpacity(0.8)),
                borderRadius: BorderRadius.circular(5)),
            child: Text("Sửa hồ sơ",
                style: AppTextStyle.appTextStyle(
                    context, 15, AppColors.black, FontWeight.normal)),
          ),
        ),
        Width(space: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(5)),
          child: SvgPicture.asset(
            'assets/images/logout.svg',
            width: 17,
            height: 17,
          ),
        )
      ],
    );
  }

  Row _buildInfo(BuildContext context) {
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
                Text(
                  "11",
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
              Text(
                "12",
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
                Text(
                  "6",
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

  ClipRRect _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: 'https://picsum.photos/seed/5/200',
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
          errorWidget: (context, url, error) => Icon(Icons.error)),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Tên người dùng",
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
