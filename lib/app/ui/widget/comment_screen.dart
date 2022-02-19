import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/comment_controller.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:final_app/app/utils/time/timeago_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final String id;

  const CommentScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController controller = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    commentController.updatePostId(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: ListTile(
                  title: Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    child: TextField(
                      controller: controller,
                      cursorColor: AppColors.redButton,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.grey.withOpacity(0.9)),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5),
                          ),
                          hintText: "Nhập bình luận của bạn ",
                          alignLabelWithHint: false,
                          filled: true),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () => {
                      print(controller.text),
                      commentController.postComment(controller.text),
                      controller.clear()
                    },
                    child: Icon(
                      CupertinoIcons.play,
                      color: AppColors.redButton,
                    ),
                  )),
            ),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width,
              color: AppColors.white,
              child: Center(
                child: Text(
                  "${commentController.comments.length} Bình luận",
                  style: AppTextStyle.appTextStyle(
                      context, 10, AppColors.grey, FontWeight.bold),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                  child: ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                                imageUrl: comment.profilePhoto,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover))),
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
                              Height(space: 10),
                              Text(
                                "@" + comment.username,
                                style: AppTextStyle.appTextStyle(context, 12,
                                    AppColors.grey, FontWeight.bold),
                              ),
                              Height(space: 8),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.comment,
                                style: AppTextStyle.appTextStyle(context, 14,
                                    AppColors.black, FontWeight.normal),
                              ),
                              Height(space: 3),
                              Text(
                                timeago.format(comment.datePublished.toDate(),
                                    locale: 'vi'),
                                style: AppTextStyle.appTextStyle(context, 12,
                                    AppColors.grey, FontWeight.normal),
                              )
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  commentController.likeComment(comment.id);
                                },
                                child: comment.likes
                                        .contains(authController.user.uid)
                                    ? Icon(
                                        CupertinoIcons.heart_solid,
                                        color: AppColors.redButton,
                                      )
                                    : Icon(
                                        CupertinoIcons.heart,
                                        color: AppColors.grey,
                                      ),
                              ),
                              Text(
                                comment.likes.length.toString(),
                                style: AppTextStyle.appTextStyle(context, 14,
                                    AppColors.grey, FontWeight.normal),
                              ),
                              Height(space: 10),
                            ],
                          ),
                        );
                      })),
            )
          ],
        ),
      )),
    );
  }
}
