import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
 String imgUrl;
 String message;
 String sendBy;
 final ts;

  Message({
    required this.imgUrl,
    required this.message,
    required this.sendBy,
    required this.ts,
  });

  Map<String, dynamic> toJson() => {
   "imgUrl": imgUrl,
    "message": message,
    "sendBy": sendBy,
    "ts": ts,
  };

  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Message(
        imgUrl: snapshot['imgUrl'],
        message: snapshot['message'],
        sendBy: snapshot['sendBy'],
        ts: snapshot['ts']);
  }
}