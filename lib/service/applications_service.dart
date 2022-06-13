import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/service/firebase_job_service.dart';

class ApplicationsService {
  List<String> applications = [];
  String userId = "";
  Future<void> getApplications() async {
    userId = await FirebaseJobService().getUserId();
    try {
      CollectionReference _collectionRef =
          Firestore.instance.collection('applications');

      QuerySnapshot querySnapshot = await _collectionRef.getDocuments();

      for (var element in querySnapshot.documents) {
        if (element.data['user_id'] == userId) {
          applications.add(element.data['job_id']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool applicationsContains(String id) {
    for (int i = 0; i < applications.length; i++) {
      if (applications[i] == id) return true;
    }
    return false;
  }

  List<JobsResult> filterList(List<JobsResult> list) {
    List<JobsResult> filteredList = [];

    for (int i = 0; i < list.length; i++) {
      if (!applicationsContains(list[i].jobId)) {
        filteredList.add(list[i]);
      }
    }
    return filteredList;
  }
}
