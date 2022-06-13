import 'package:flutter/cupertino.dart';

class FirebaseApplicationModel {
  String cvLink;
  String jobId;
  String status;
  String userId;

  FirebaseApplicationModel({
    @required this.cvLink,
    @required this.jobId,
    @required this.status,
    @required this.userId,
  });

  FirebaseApplicationModel.fromMap(Map<dynamic, dynamic> data, String id)
      : cvLink = data['cv_link'] ?? '',
        jobId = data['job_id'] ?? '',
        status = data['status'] ?? '',
        userId = data['user_id'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      "cv_link": cvLink,
      "job_id": jobId,
      "status": status,
      "user_id": userId,
    };
  }
}
