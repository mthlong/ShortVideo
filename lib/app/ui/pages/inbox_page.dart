import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_images.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/chat_controller.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:final_app/app/controllers/search_controller.dart';
import 'package:final_app/app/data/entity/user.dart';
import 'package:final_app/app/ui/pages/chat_screen.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:final_app/app/ui/widget/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  late String chatRoomId, messageId = "";
  final ProfileController controller = Get.find<ProfileController>();
  final ChatController chatController = Get.put(ChatController());
  late Stream<QuerySnapshot> chatRoomStream;
  late String myUid, myUserName, myEmail, myProfilePic;

  getMyProfile() {
    myUid = controller.user['uid'];
    myUserName = controller.user['name'];
    myEmail = controller.user['email'];
    myProfilePic = controller.user['profilePhoto'];
  }

  getIdRoom(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  getAndSetRoom() {
    chatRoomStream = chatController.getChatRoomList(myUserName);
    setState(() {

    });
  }

  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatRoomStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ChatListTitle(lastMessage: ds['lastMessage'], chatRoomId: ds.id, myUsername: myUserName, controller: chatController, lastMessageSendTs: ds['lastMessageSendTs'], );
                }),
          )
              : Padding(
                padding: const EdgeInsets.only(top:80.0),
                child: const EmptyView(mess: "Không có cuộc trò chuyện gần đây",),
              );
        });
  }

  @override
  void initState() {
    super.initState();
    controller.updateUserId(authController.user.uid);
    getMyProfile();
    getAndSetRoom();
  }

  final SearchController searchController = Get.put(SearchController());

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
            ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text("Danh sách tin nhắn gần đây", style: AppTextStyle.appTextStyle(context, 14, AppColors.grey, FontWeight.bold),),
                ),
                chatRoomList(),
              ],
            )
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
                          onTap: () {
                            var chatRoomID = getIdRoom(myUserName, user.name);
                            Map<String, dynamic> chatRoomInfoMap = {
                              "users": [myUserName, user.name]
                            };
                            chatController.creatChatRoom(chatRoomID, chatRoomInfoMap);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => new ChatScreen(
                                  chatWithUsername: user.uid,
                                  name: user.name,
                                  profilePhoto: user.profilePhoto,
                                ),
                              ),
                            );
                          },
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
                                Text(user.name,
                                    style: AppTextStyle.appTextStyle(context, 17,
                                        AppColors.black, FontWeight.normal)),
                                Height(space: 7),
                                Text(user.email,
                                    style: AppTextStyle.appTextStyle(
                                      context,
                                      13,
                                      AppColors.grey,
                                      FontWeight.bold,
                                    ))
                              ],
                            ),
                            trailing: Icon(
                              CupertinoIcons.mail,
                              color: AppColors.grey,
                            ),
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






class ChatListTitle extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  final lastMessageSendTs;
  final ChatController controller;
  const ChatListTitle({Key? key, required this.lastMessage, required this.chatRoomId, required this.myUsername, required this.controller, required this.lastMessageSendTs}) : super(key: key);

  @override
  _ChatListTitleState createState() => _ChatListTitleState();
}

class _ChatListTitleState extends State<ChatListTitle> {
  late String name = "";
  late String profilePicUrl= "";
  String username= "";
  getThisUserInfo() async {
    username = widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await widget.controller.getUserInfo(username);
    print("Đây nè"+ querySnapshot.docs.toString());
    name = "${querySnapshot.docs[0]['name']}";
    profilePicUrl = "${querySnapshot.docs[0]['profilePhoto']}";
    setState(() {

    });
  }
  @override
  void initState() {
    getThisUserInfo();
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ()  {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => new ChatScreen(
              chatWithUsername: username,
              name: name,
              profilePhoto: profilePicUrl,
            ),
          ),
        );
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 40,
              width: 40,
              imageUrl: profilePicUrl,
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
                name,
                style: AppTextStyle.appTextStyle(
                    context, 17, AppColors.black, FontWeight.normal)
            ),
            Height(space: 7),
            Text(widget.lastMessage,style: AppTextStyle.appTextStyle(
              context, 13, AppColors.grey, FontWeight.bold,))
          ],
        ),
        trailing: Text(timeago.format(widget.lastMessageSendTs.toDate(),
            locale: 'vi'),
          style: AppTextStyle.appTextStyle(context, 12,
              AppColors.grey, FontWeight.normal),)
      ),
    );
  }
}
