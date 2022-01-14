import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class HomeSideBar extends StatefulWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, color: AppColors.white);
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _profileImageButton(),
          _sideBarItem('heart', '1.2M', style),
          _sideBarItem('comment', '213', style),
          _sideBarItem('share', '10', style),
          AnimatedBuilder(animation: _animationController,
              child: Stack(children: [Container(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/disc.png'),
              )],),
              builder: (context, child){
            return Transform.rotate(angle: 2 * pi * _animationController.value,
            child: child,);
          })

        ],
      ),
    );
  }

  _sideBarItem(String iconName, String label, TextStyle style) {
    return Column(children: [
      SvgPicture.asset('assets/images/$iconName.svg'),
      SizedBox(height: 5,),
      Text(label, style: style,)
    ],);
  }

  _profileImageButton() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/id/1062/400/400',
                imageBuilder: (context, imageProvider) =>
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                placeholder: (context, url) => GFLoader(),
                errorWidget: (context, url, error) => Icon(Icons.error)),
          ),
        ),
        Positioned(
            bottom: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.add_outlined,
                color: AppColors.white,
                size: 20,
              ),
            ))
      ],
    );
  }
}
