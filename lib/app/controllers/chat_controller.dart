import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/data/entity/message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final Rx<List<Message>> _messageList = Rx<List<Message>>([]);

  List<Message> get messageList => _messageList.value;

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future addMessage(var chatRoomID, var messageID,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomID)
        .collection('chats')
        .doc(messageID)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  creatChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot =
        await firestore.collection('chatrooms').doc(chatRoomId).get();
    if (snapShot.exists) {
      return true;
    } else {
      return firestore
          .collection('chatrooms')
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Stream<QuerySnapshot> getChatRoomMessage(chatRoomID) {
    return firestore
        .collection('chatrooms')
        .doc(chatRoomID)
        .collection("chats")
        .orderBy('ts', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatRoomList(String myUserName) {
    return firestore
        .collection('chatrooms')
        .where('users', arrayContains: myUserName).snapshots();
  }
  Future<QuerySnapshot> getUserInfo(String name) async {
    return firestore.collection('users').where('name', isEqualTo: name).get();
  }

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    _user.value.clear();
    List<String> thumbnails = [];
    List<String> videoUrls = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
      videoUrls.add((myVideos.docs[i].data() as dynamic)['videoUrl']);
    }

    DocumentSnapshot userDoc =
    await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String uid = userData['uid'];
    String name = userData['name'];
    String bio = userData['bio'];
    String email = userData['email'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
    });

    _user.value = {
      'uid': uid,
      'followers': followers.toString(),
      'following': following.toString(),
      'likes': likes.toString(),
      'bio': bio,
      'email': email,
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
      'videoUrls': videoUrls,
    };
    update();
  }
}
