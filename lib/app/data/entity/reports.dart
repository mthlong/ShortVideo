import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final sendTime;
  String fromUserId;
  String videoId;
  String id;
  String reportAbout;

  Report({required this.sendTime,
    required this.fromUserId,
    required this.id,
    required this.reportAbout,
    required this.videoId});


  Map<String, dynamic> toJson() =>
      {
        'sendTime': sendTime,
        'fromUserId': fromUserId,
        'id': id,
        'reportAbout': reportAbout,
        'videoId': videoId,
      };

  static Report fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Report(sendTime: snapshot['sendTime'],
        fromUserId: snapshot['fromUserId'],
        id: snapshot['id'],
        reportAbout: snapshot['reportAbout'],
        videoId: snapshot['videoId']);
  }
}
