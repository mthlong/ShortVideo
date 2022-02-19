import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/app/constants/firebase_constants.dart';
import 'package:final_app/app/data/entity/reports.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  sendReport(String reportAbout, String fromUserId, String videoId) async {
    try {
      if (reportAbout.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid;
        DocumentSnapshot userDoc =
        await firestore.collection('users').doc(uid).get();
        var allDocs = await firestore.collection('reports').get();
        int len = allDocs.docs.length;
        Report report = Report(sendTime: DateTime.now(),
            fromUserId: uid,
            id: "Report $len",
            reportAbout: reportAbout,
            videoId: videoId);
        await firestore.collection('reports').doc('Reports $len').set(report.toJson());
        Get.snackbar(
          'Xác nhận',
          'Báo cáo thành công',
        );}
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        e.toString(),
      );
      }
  }
}