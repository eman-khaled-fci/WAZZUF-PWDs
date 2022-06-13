
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wuzzuf_pwd/models/firebase_application_model.dart';
import 'package:wuzzuf_pwd/models/firebase_job_model.dart';

class FirebaseJobService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<String> fireListIds = [];
  Map<String, bool> fireApi;
  FirebaseJobService({this.fireApi});
  Future<List<FirebaseJobModel>> getData() async {
    CollectionReference _collectionRef = Firestore.instance.collection('job');
    QuerySnapshot querySnapshot = await _collectionRef.getDocuments();
    List<FirebaseJobModel> allData = [];
    for (var element in querySnapshot.documents) {
      allData.add(FirebaseJobModel.fromMap(element.data));
      fireApi[element.data['id']] = true;
    }
    return allData;
  }

  void upLoad(FirebaseJobModel model) {
    Firestore.instance.collection("job").add(model.toMap());
  }

  void upLoadApplication(FirebaseApplicationModel model) {
    Firestore.instance.collection("applications").add(model.toMap());
  }

  Future<String> getUserId() async {
    final FirebaseUser user = await auth.currentUser();
    final String uid = user.uid;
    return uid;
  }
}
