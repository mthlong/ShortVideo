import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/constants/app_text_style.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/controllers/chat_controller.dart';
import 'package:final_app/app/controllers/profile_controller.dart';
import 'package:final_app/app/ui/widget/empty_view.dart';
import 'package:final_app/app/ui/widget/space_width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:random_string/random_string.dart';
import 'dart:core';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name, profilePhoto;

  const ChatScreen(
      {Key? key,
      required this.chatWithUsername,
      required this.name,
      required this.profilePhoto})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String chatRoomId, messageId = "";
  late final String myUid, myUserName, myEmail, myProfilePic;
  ProfileController controller = Get.find<ProfileController>();
  late Stream<QuerySnapshot> messageStream;
  final TextEditingController messageController = TextEditingController();

  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    controller.updateUserId(authController.user.uid);
    doThisOnLauch();
    // chatController.getMessage(chatRoomId);
    super.initState();
  }

  getMyProfile() {
    myUid = controller.user['uid'];
    myUserName = controller.user['name'];
    myEmail = controller.user['email'];
    myProfilePic = controller.user['profilePhoto'];
    chatRoomId = getIdRoom(widget.name, myUserName);
  }

  getIdRoom(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getAndSetMessage() {
    messageStream = chatController.getChatRoomMessage(chatRoomId);
    setState(() {});
  }

  Widget chatMessageTitle(String message, bool sendByMe, String photoUrl) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Visibility(
          visible: !sendByMe ? true : false,
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 40,
              width: 40,
              imageUrl:photoUrl,
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => GFShimmer(
                  child: Container(
                    color: AppColors.white.withOpacity(0.5),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  )),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error)),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: !sendByMe ? AppColors.redButton : AppColors.white, width: !sendByMe ? 1 : 0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomLeft:
                      !sendByMe ? Radius.circular(0) : Radius.circular(13),
                  bottomRight:
                      !sendByMe ? Radius.circular(13) : Radius.circular(0)),
              color:  !sendByMe ? AppColors.white : AppColors.redButton),
          child: Container(
            width: message.length >= 27 ? MediaQuery.of(context).size.width - 120 : null,
            child: Text(
              message,
              maxLines: 5,
              style: AppTextStyle.appTextStyle(
                  context, 16, !sendByMe ? AppColors.redButton : AppColors.white, FontWeight.normal),
            ),
          ),
        ),
        Visibility(
          visible: sendByMe ? true : false,
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 40,
              width: 40,
              imageUrl: photoUrl,
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => GFShimmer(
                  child: Container(
                    color: AppColors.white.withOpacity(0.5),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  )),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error)),
        ),
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder<QuerySnapshot>(
        stream: messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    padding: EdgeInsets.only(bottom: 70, top: 16),
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return chatMessageTitle(
                          ds['message'], myUserName == ds['sendBy'], myUserName == ds['sendBy'] ? myProfilePic : widget.profilePhoto);
                    }),
              )
              : EmptyView(mess: "Không có tin nhắn nào, hãy trò chuyện thêm với nhau nhé",);
        });
  }

  addMessage(bool sendClicked) {
    if (messageController.text != "") {
      String message = messageController.text;
      var lastMessageTs = DateTime.now();
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic
      };
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      chatController
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          'lastMessage': message,
          'lastMessageSendTs': lastMessageTs,
          'lastMessageSendBy': myUserName,
        };
        chatController.updateLastMessageSend(chatRoomId, lastMessageInfoMap);
        if (sendClicked) {
          messageController.clear();
          messageId = "";
        }
      });
    }
  }

  doThisOnLauch() {
    getMyProfile();
    getAndSetMessage();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                  imageUrl: widget.profilePhoto,
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover))),
                  placeholder: (context, url) => GFShimmer(
                          child: Container(
                        color: AppColors.white.withOpacity(0.5),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      )),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error)),
              const Width(space: 14),
              Text(
                widget.name,
                style: AppTextStyle.appTextStyle(
                    context, 17, AppColors.black, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessage(),
            Container(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                  title: Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    child: TextField(
                      // onChanged: (value) => addMessage(false),
                      controller: messageController,
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
                          hintText: "Nhập tin nhắn",
                          alignLabelWithHint: false,
                          filled: true),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () => {
                      addMessage(true),
                      messageController.clear(),
                    },
                    child: Icon(
                      CupertinoIcons.play,
                      color: AppColors.redButton,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
