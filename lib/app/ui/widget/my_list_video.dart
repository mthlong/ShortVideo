import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:final_app/app/ui/pages/watch_video_page.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

class MyVideoList extends StatelessWidget {
  final ProfileController controller;
  final List<String>? thumbnail;
  final List<String>? videoUrl;
  final List<Video>? videoList;
  const MyVideoList({Key? key, required this.thumbnail, this.videoUrl, required this.controller, required this.videoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=> _buidBody(controller.isLoading));
  }
  Widget _buidBody(RxBool _isLoading){
    if (thumbnail == null && _isLoading.value == true){
      return GFLoader();
    } if(thumbnail != null && _isLoading.value == false){
  return GridView.builder(
      itemCount: thumbnail!.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(2),
          child: InkWell(
            onTap: ()=> Get.to(()=> WatchVideo(videoUrl: videoUrl![index], video: videoList![index],)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: thumbnail![index],
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                    placeholder: (context, url) => GFShimmer(
                        child: Container(
                          color: AppColors.white.withOpacity(0.5),
                        )),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
                Container(color: AppColors.black.withOpacity(0.5),),
                Icon(CupertinoIcons.play_arrow_solid, color: AppColors.white.withOpacity(0.5),size: 30,)
              ],
            ),
          ),
        );
      });
    } if(thumbnail == null && _isLoading.value == false) {
      return EmptyView(mess: "Không có video nào :'(",);
    } else return Container();
  }
}
