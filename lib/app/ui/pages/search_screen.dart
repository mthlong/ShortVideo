import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/controllers/search_controller.dart';
import 'package:final_app/app/controllers/video_controller.dart';
import 'package:final_app/app/data/entity/user.dart';
import 'package:final_app/app/ui/pages/profile_page.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.onClose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.25,
          centerTitle: false,
          leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                CupertinoIcons.back,
                color: AppColors.black,
              )),
          title: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(2),
            ),
            child: TextFormField(
              onFieldSubmitted: (value) => searchController.searchUser(value),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey.shade500,
              decoration: InputDecoration(
                hintText: "Tìm kiếm người dùng ...",
                hintStyle: AppTextStyle.appTextStyle(
                    context, 16, Colors.grey.shade500, FontWeight.w500),
                border: InputBorder.none,
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: AppColors.black,
                ),
              ),
              style: AppTextStyle.appTextStyle(
                  context, 16, AppColors.black, FontWeight.w500),
            ),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? EmptyView(mess: "Nhập tên người dùng cần tìm kiếm")
            : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text("Kết quả tìm kiếm", style: AppTextStyle.appTextStyle(context, 14, AppColors.grey, FontWeight.bold),),
                ),
                Container(
          padding: EdgeInsets.only(top: 50),
                  child: ListView.builder(
                      itemCount: searchController.searchedUsers.length,
                      itemBuilder: (context, index) {
                        User user = searchController.searchedUsers[index];
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(uid: user.uid),
                            ),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                  imageUrl: user.profilePhoto,
                                  imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider, fit: BoxFit.cover))),
                                  placeholder: (context, url) => GFShimmer(
                                      child: Container(
                                        color: AppColors.white.withOpacity(0.5),
                                        height: 40,
                                        width: 40,
                                      )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error)),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: AppTextStyle.appTextStyle(
                                      context, 17, AppColors.black, FontWeight.normal)
                                ),
                                Height(space: 7),
                                Text(user.email,style: AppTextStyle.appTextStyle(
                                  context, 13, AppColors.grey, FontWeight.bold,))
                              ],
                            ),
                            trailing: Icon(CupertinoIcons.profile_circled, color: AppColors.grey,),
                          ),
                        );
                      },
                    ),
                ),
              ],
            ),
      );
    });
  }
}
