import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

class DiscoverSection extends StatelessWidget {
  const DiscoverSection({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: _buildHeader(context, 0.2 * height),),
        Height(space: 16),
        Container(
          height: 0.65 * height,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.9,
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: 'https://picsum.photos/seed/{$index}/200/300',
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover))),
                      placeholder: (context, url) => GFShimmer(child: Container(color: AppColors.white.withOpacity(0.5), height: 0.65 * height, width: MediaQuery.of(context).size.width / 3.9,)),
                      errorWidget: (context, url, error) => Icon(Icons.error)),
                  ),
                );
            }),
          ),
        )
      ],
    );
  }

  _buildHeader(BuildContext context, double height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: height - 12,
          width: height - 12,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(height),
          ),
          child: Text("#",style: AppTextStyle.appTextStyleCaption(
              context, 24, null),),
        ),
        Width(space: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tên Trend",
              style: AppTextStyle.appTextStyle(
                  context, 14, AppColors.black, FontWeight.bold),
            ),
            Height(space: 5),
            Text(
              "Hashtag thịnh hành",
              style: AppTextStyle.appTextStyleCaption(
                  context, 12, FontWeight.bold),
            )
          ],
        ),
        Spacer(),
        Container(height: height/2,
        color: Colors.grey.shade300,
          padding: EdgeInsets.only(left: 6),
          alignment: Alignment.center,
          child: Row(children: [
            Text("2.7M", style: AppTextStyle.appTextStyle(context, 13, null, FontWeight.bold),),
            Icon(Icons.chevron_right,size: 17,)
          ],),
        )
      ],
    );
  }
}
