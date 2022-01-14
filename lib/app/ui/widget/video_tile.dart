import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  const VideoTile({Key? key, required this.video, required this.snappedPageIndex, required this.currentIndex}) : super(key: key);
  final Video video;
  final int snappedPageIndex;
  final int currentIndex;
  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _videoPlayerController;
  late Future _initializeVideoPlayer;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController =
        VideoPlayerController.asset('assets/${widget.video.videoUrl}');
    _initializeVideoPlayer = _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    (widget.snappedPageIndex == widget.currentIndex) ? _videoPlayerController.play() : _videoPlayerController.pause();
    return Container(
      color: AppColors.black,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: [
              SizedBox.expand(child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                      width: _videoPlayerController.value.size.width,
                      height: _videoPlayerController.value.size.height,
                      child: VideoPlayer(_videoPlayerController)))),
            ],);
          } else {
            return Container(
              alignment: Alignment.center,
              child: Lottie.asset('assets/images/tiktok-loader.json',fit: BoxFit.cover, width: 100, height: 100),
            );
          }
        },
      ),
    );
  }
}
