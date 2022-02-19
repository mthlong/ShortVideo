import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:final_app/app/controllers/video_controller.dart';
import 'package:final_app/app/data/entity/firebase_file.dart';
import 'package:final_app/app/data/entity/mock_data.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:final_app/app/ui/widget/video_detail.dart';
import 'package:final_app/app/ui/widget/home_side_bar.dart';
import 'package:final_app/app/ui/widget/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFollowingSelected = true;
  int _snappedPageIndex = 0;
  VideoController _videoController = Get.put(VideoController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body:
        Obx(()=>Stack(
          children: [
            Visibility(
                visible: _videoController.videoList.isEmpty ? true : false,
                child: EmptyView(mess: "Không có video nào",)),
            Visibility(
              visible: _videoController.videoList.isNotEmpty ? true: false,
              child: PreloadPageView.builder(
                  onPageChanged: (int page) {
                    setState(() {
                      _snappedPageIndex = page;
                    });
                  },
                  preloadPagesCount: 1,
                  scrollDirection: Axis.vertical,
                  itemCount: _videoController.videoList.length,
                  itemBuilder: (context, index) {
                    final data = _videoController.videoList[index];
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        //Remember opening at tomorrow
                        VideoTile(videoUrl: data.videoUrl, currentIndex: index, snappedPageIndex: _snappedPageIndex,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: VideoDetail(video: data,),
                                )),
                            Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 1.75,
                                  child: HomeSideBar(video: data),
                                ))
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ],
        ))
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      // title: Stack(
      //   alignment: Alignment.center,
      //
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //             setState(() {
      //               _isFollowingSelected = true;
      //             });
      //           },
      //
      //           child: Text(
      //             "Following",
      //             style: AppTextStyle.appTextStyleShadow(
      //               context,
      //               _isFollowingSelected ? 18 : 15,
      //               _isFollowingSelected ? AppColors.white : AppColors.grey,
      //               FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //         Width(space: 50),
      //         GestureDetector(
      //           onTap: () {
      //             setState(() {
      //               _isFollowingSelected = false;
      //             });
      //           },
      //           child: Text(
      //             "For you",
      //             style: AppTextStyle.appTextStyleShadow(
      //               context,
      //               !_isFollowingSelected ? 18 : 15,
      //               !_isFollowingSelected ? AppColors.white : AppColors.grey,
      //               FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Text("     |",
      //         style: AppTextStyle.appTextStyle(context, 15, AppColors.white, null)),
      //
      //   ],
      // ),
    );
  }
}
