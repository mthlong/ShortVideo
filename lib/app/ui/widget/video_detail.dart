import 'package:expandable_text/expandable_text.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '@${video.postedBy.username}',
            style: AppTextStyle.appTextStyle(
                context, 15, AppColors.white, FontWeight.bold),
          ),
          const Height(space: 8),
          ExpandableText(
            video.caption,
            style: AppTextStyle.appTextStyle(
                context, 13, AppColors.white, FontWeight.w100),
            expandText: 'Xem thêm',
            collapseText: 'Ẩn',
            expandOnTextTap: true,
            collapseOnTextTap: true,
            maxLines: 2,
            linkColor: AppColors.grey,
          ),
          const Height(space: 8),
          Row(
            children: [
              const Icon(
                CupertinoIcons.music_note_2,
                size: 15,
                color: Colors.white,
              ),
              const Width(space: 8),
              Container(height: 20, width: MediaQuery.of(context).size.width / 2, child: Marquee(
                text: "${video.audioName}   •   ",
                velocity: 8,
                style: AppTextStyle.appTextStyle(context, 13, AppColors.white, FontWeight.w100),
              ),),

            ],
          )
        ],
      ),
    );
  }
}
