import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class VideoOnly extends StatefulWidget {
  const VideoOnly({Key? key,
    required this.videoUrl,})
      : super(key: key);
  final String videoUrl;


  @override
  _VideoOnlyState createState() => _VideoOnlyState();
}

class _VideoOnlyState extends State<VideoOnly> {
  late VideoPlayerController _videoPlayerController;
  late Future _initializeVideoPlayer;
  bool _isVideoPlaying = false;

  void playAndStopVideo() {
    _isVideoPlaying ? _videoPlayerController.pause() : _videoPlayerController
        .play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController =
        VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer = _videoPlayerController.initialize();
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
    return GestureDetector(
      onTap: () {playAndStopVideo();},
      child: Container(
        color: AppColors.black,
        child: FutureBuilder(
          future: _initializeVideoPlayer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                              width: _videoPlayerController.value.size.width,
                              height: _videoPlayerController.value.size.height,
                              child: VideoPlayer(_videoPlayerController)))),
                  IconButton(
                      onPressed: () => playAndStopVideo(),
                      icon: Icon(Icons.play_arrow,
                          color: AppColors.white.withOpacity(_isVideoPlaying ? 0 : 0.5), size: 80))
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/tiktok-loader.json',
                    fit: BoxFit.cover, width: 100, height: 100),
              );
            }
          },
        ),
      ),
    );
  }
}
