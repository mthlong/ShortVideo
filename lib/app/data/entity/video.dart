import 'package:final_app/app/data/entity/user.dart';

class Video {
  final String videoUrl;
  final User postedBy;
  final String caption;
  final String audioName;
  final int likes;
  final int comments;

  Video(this.videoUrl, this.postedBy, this.caption, this.audioName, this.likes, this.comments);

}