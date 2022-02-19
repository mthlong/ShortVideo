import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/data/entity/video.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  final RxBool isLoading = false.obs;

  bool isFollowing = false;

  List<Video> get videoList => _videoList.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    isLoading.value = true;
    List<String> thumbnails = [];
    List<String> videoUrls = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    _videoList.bindStream(firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));

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
    isFollowing = false;

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
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'uid': uid,
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'bio': bio,
      'email': email,
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
      'videoUrls': videoUrls,
      'videoList': videoList,
    };
    isLoading.value = false;
    update();
  }


  Future<String> _uploadToStorage(File file) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void changePassword(String newPass) async{
    try {
      await firebaseAuth.currentUser!.updatePassword(newPass);
      Get.snackbar('Cập nhật thành công', 'Mật khẩu của bạn đã được cập nhật !!!');
    }
    catch (e) {
      Get.snackbar('Lỗi khi thay đổi mật khẩu', e.toString());
    }
  }
  
  
  void updateBio(String id, String bio) async {
    try {
      await firestore.collection('users').doc(id).update({'bio': bio});
      Get.snackbar('Cập nhật thành công', 'Phần mô tả của bạn đã được cập nhật !!!');
      update();
    }
    catch (e) {
      Get.snackbar('Lỗi khi cập nhật', e.toString());
    }
  }

  void updateName(String id, String name) async {
    try {
      await firestore.collection('users').doc(id).update({'name': name});
      Get.snackbar('Cập nhật thành công', 'Tên của bạn đã được cập nhật !!!');
      update();
    }
    catch (e) {
      Get.snackbar('Lỗi khi cập nhật', e.toString());
    }
  }

  void updateAvatar(String id, File? image) async {
    try {
      String downloadUrl  = await _uploadToStorage(image!);
      await firestore.collection('users').doc(id).update({'profilePhoto': downloadUrl});
      Get.snackbar('Cập nhật thành công', 'Ảnh đại diện của bạn đã được cập nhật !!!');
      update();
    }
    catch (e) {
      Get.snackbar('Lỗi khi cập nhật', e.toString());
    }
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
  @override
  void onInit() {
    super.onInit();
  }
}
