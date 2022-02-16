import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/firebase_constants.dart';

class User {
  final String name;
  final String email;
  final String profilePhoto;
  final String uid;
  final String bio;

  User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.profilePhoto,
      required this.bio});

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "bio": bio
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto'],
        bio: snapshot['bio']);
  }
}
