import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

class MyLoveVideoList extends StatelessWidget {
  const MyLoveVideoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(2),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'https://picsum.photos/seed/${index+5}/200',
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover))),
                placeholder: (context, url) => GFShimmer(
                    child: Container(
                      color: AppColors.white.withOpacity(0.5),
                    )),
                errorWidget: (context, url, error) => Icon(Icons.error)),
          );
        });
  }
}
