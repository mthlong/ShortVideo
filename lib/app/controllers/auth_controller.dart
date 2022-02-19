import 'dart:io';

import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/ui/navigation_container.dart';
import 'package:final_app/app/ui/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:final_app/app/data/entity/user.dart' as model;

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  late Rx<User?> _user;
  User get user => _user.value!;

  static AuthController instance = Get.find();
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

  //dang ky
  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        isLoading.value = true;
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl  = await _uploadToStorage(image);
        model.User user = model.User(
            name: username,
            email: email,
            uid: cred.user!.uid,
            profilePhoto: downloadUrl ,
            bio: "Chưa cập nhật");
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        Get.snackbar('Tạo tài khoản thành công', 'Vui lòng đăng nhập vào ứng dụng');
        isLoading.value = false;
      } else {
        Get.snackbar('Lỗi khi tạo tài khoản', 'Vui lòng điền đủ vào các trường');
      }
    } catch (e) {
      print("Đây nè" + e.toString());
      isLoading.value = false;
      Get.snackbar('Lỗi khi tạo tài khoản', e.toString());
    }
  }
  void loginUser(String email, String password) async {
    try {
      if(email.isNotEmpty && password.isNotEmpty) {
        isLoading.value = true;
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar('Đăng nhập thành công', 'Ứng dụng đang được chuyển tới trang chủ');
        isLoading.value = false;
      } else
        Get.snackbar('Lỗi đăng nhập', 'Tài khoản hoặc mật khẩu không được để trắng');
    } catch (e) {
      isLoading.value = false;
      print("Đây nè" + e.toString());
      Get.snackbar('Lỗi đăng nhập', e.toString());
    }
  }
  void signOut() async {
    await firebaseAuth.signOut();
}
  @override
  void onInit()  {
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }
  _setInitialScreen(User? user) {
    if(user == null) {
      Get.offAll(()=>LoginPage());
    } else
      {
        Get.offAll(()=> NavigationContainer());
      }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
