import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/controllers/auth_controller.dart';
import 'package:final_app/app/controllers/video_controller.dart';
import 'package:final_app/app/data/entity/firebase_file.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:final_app/app/ui/widget/comment_screen.dart';
import 'package:final_app/app/ui/widget/share_screen.dart';
import 'package:final_app/app/utils/number/number_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:like_button/like_button.dart';

class HomeSideBar extends StatefulWidget {
  const HomeSideBar({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  VideoController _controller = Get.put(VideoController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle.appTextStyle(context, 13, AppColors.white, null);
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _profileImageButton(widget.video.profilePhoto),
          GestureDetector(
            onTap: () {
              _controller.likeVideo(widget.video.id);
            },
            child: _sideBarItem(
                'heart',
                widget.video.likes.length.toString(),
                style,
              widget.video.likes.contains(authController.user.uid) ? Colors.red : Colors.white.withOpacity(0.75)
            ),
          ),
          InkWell(
            onTap: () {setState(() {
              _onButtonPress();
            });} ,
            child: _sideBarItem('comment', widget.video.commentCount.toString(), style,
                Colors.white.withOpacity(0.75)),
          ),
          InkWell(
            onTap: () {
              _onShareButtonPress();
            },
            child: _sideBarItem('share', widget.video.shareCount.toString(), style,
              Colors.white.withOpacity(0.75)),),
          AnimatedBuilder(
              animation: _animationController,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/disc.png'),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 20,
                        width: 20,
                        imageUrl: widget.video.profilePhoto,
                        imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover))),
                        placeholder: (context, url) => GFShimmer(
                                child: Container(
                              color: AppColors.white.withOpacity(0.5),
                              height: 20,
                              width: 20,
                            )),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error)),
                  ),
                ],
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: 2 * pi * _animationController.value,
                  child: child,
                );
              })
        ],
      ),
    );
  }

  _sideBarItem(String iconName, String label, TextStyle style, Color color) {
    return Column(
      children: [
        SvgPicture.asset('assets/images/$iconName.svg', color: color),
        SizedBox(
          height: 5,
        ),
        Text(
          NumberFormatter.formatter(label),
          style: style,
        )
      ],
    );
  }

  _profileImageButton(String imageUrl) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover))),
                placeholder: (context, url) => GFShimmer(
                        child: Container(
                      color: AppColors.white.withOpacity(0.5),
                      height: 50,
                      width: 50,
                    )),
                errorWidget: (context, url, error) => Icon(Icons.error)),
          ),
        ),
        Positioned(
            bottom: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.add_outlined,
                color: AppColors.white,
                size: 20,
              ),
            ))
      ],
    );
  }

  void _onShareButtonPress() {
    showModalBottomSheet(context: context, builder: (context){
      return ShareScreen(id: widget.video.id,);
    });
  }

  void _onButtonPress() {
    showModalBottomSheet(context: context, builder: (context){
      return CommentScreen(id: widget.video.id,);
    });
  }

}
