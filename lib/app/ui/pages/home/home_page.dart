import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/data/entity/mock_data.dart';
import 'package:final_app/app/ui/widget/video_detail.dart';
import 'package:final_app/app/ui/widget/home_side_bar.dart';
import 'package:final_app/app/ui/widget/video_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFollowingSelected = true;
  int _snappedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: PageView.builder(
            onPageChanged: (int page) {
              setState(() {
                _snappedPageIndex = page;
              });
            },
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoTile(video: videos[index], currentIndex: index, snappedPageIndex: _snappedPageIndex,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: VideoDetail(video: videos[index],),
                          )),
                      Expanded(
                          child: Container(
                        height: MediaQuery.of(context).size.height / 1.75,
                        child: HomeSideBar(video: videos[index],),
                      ))
                    ],
                  )
                ],
              );
            }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isFollowingSelected = true;
              });
            },
            child: Text(
              "Following",
              style: AppTextStyle.appTextStyleShadow(
                context,
                _isFollowingSelected ? 18 : 15,
                _isFollowingSelected ? AppColors.white : AppColors.grey,
                FontWeight.w600,
              ),
            ),
          ),
          Text("    |    ",
              style: AppTextStyle.appTextStyle(context, 15, AppColors.white, null)),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFollowingSelected = false;
              });
            },
            child: Text(
              "For you",
              style: AppTextStyle.appTextStyleShadow(
                context,
                !_isFollowingSelected ? 18 : 15,
                !_isFollowingSelected ? AppColors.white : AppColors.grey,
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
