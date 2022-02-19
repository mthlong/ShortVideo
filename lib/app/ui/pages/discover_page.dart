import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/ui/pages/search_screen.dart';
import 'package:final_app/app/ui/widget/discover_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.ease);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }
  void getToSearchScreen() {
    Get.to(()=> SearchScreen());
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.white,
          elevation: 0.25,
          pinned: true,
          centerTitle: false,
          title: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(2),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey.shade500,
              decoration: InputDecoration(
                hintText: "Tìm kiếm...",
                hintStyle: AppTextStyle.appTextStyle(
                    context, 16, Colors.grey.shade500, FontWeight.w500),
                border: InputBorder.none,
                prefixIcon: InkWell(
                  onTap: () =>getToSearchScreen(),
                  child: Icon(
                    CupertinoIcons.search,
                    color: AppColors.black,
                  ),
                ),
              ),
              style: AppTextStyle.appTextStyle(
                  context, 16, AppColors.black, FontWeight.w500),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.qrcode_viewfinder),
              color: AppColors.black,
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      _currentPageNotifier.value = page;
                    },
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://picsum.photos/seed/{$index}/600/300',
                            imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover))),
                            placeholder: (context, url) => GFShimmer(
                                    child: Container(
                                  color: AppColors.white.withOpacity(0.5),
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error)),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CirclePageIndicator(
                    currentPageNotifier: _currentPageNotifier,
                    itemCount: 5,
                    size: 5,
                    selectedSize: 5,
                  ),
                )
              ],
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.symmetric(vertical: 8)),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            height: MediaQuery.of(context).size.height / 3.75,
            child: DiscoverSection(
                height: MediaQuery.of(context).size.height / 3.75),
          );
        }, childCount: 10))
      ],
    );
  }
}
