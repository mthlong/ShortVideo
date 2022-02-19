import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:final_app/app/ui/widget/video_detail.dart';
import 'package:final_app/app/ui/widget/home_side_bar.dart';
import 'package:final_app/app/ui/widget/video_only_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchVideo extends StatefulWidget {
  final String videoUrl;
  final Video video;
  WatchVideo({Key? key, required this.videoUrl, required this.video}) : super(key: key);

  @override
  _WatchVideoState createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body:
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Mai mở
            VideoOnly(videoUrl: widget.videoUrl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: VideoDetail(video: widget.video,),
                    )),
                Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.75,
                      child: HomeSideBar(video: widget.video),
                    ))
              ],
            )
          ],
        ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(CupertinoIcons.back, color: AppColors.white,)),
    );
  }
}
