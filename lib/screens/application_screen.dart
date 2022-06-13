import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/screens/view_application_details.dart';

class Applications extends StatefulWidget {
  const Applications({Key key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  void initState() {
    super.initState();
    getUserid();
  }

  bool ready = false;
  String userid;

  getUserid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    userid = user.uid;
    ready = true;
    if (mounted) {
      setState(() {});
    }
  }

  var jobsReady = true;
  var jobs = {};
  var jobscount = 0;

  getJobData(var jobid, var ind) async {
    var templet = await Firestore.instance
        .collection('job')
        .where('id', isEqualTo: jobid)
        .getDocuments();
    if (templet.documents.isNotEmpty) {
      jobs[ind] = templet.documents[0].data;
    } else {
      jobs[ind] = null;
    }
    if (jobs.length == jobscount) {
      jobsReady = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Applications'),
        ),
        body: ready
            ? applicationsStreamBuilder()
            : const Center(child: CircularProgressIndicator()));
  }

  StreamBuilder<QuerySnapshot> applicationsStreamBuilder() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('applications')
            .where('user_id', isEqualTo: userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (jobscount != snapshot.data.documents.length) {
              jobsReady = false;
              jobscount = snapshot.data.documents.length;
              jobs.clear();
            }
            if (jobscount == 0) jobsReady = true;
            if (jobsReady == false) {
              for (int i = 0; i < jobscount; i++) {
                var jobid = snapshot.data.documents[i]['job_id'];
                getJobData(jobid, i);
              }
            }

            return jobsReady
                ? jobsListViewBuilder(snapshot)
                : const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget jobsListViewBuilder(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.data.documents.isEmpty) {
      return const Center(child: Text('you have no applications'));
    } else {
      return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            if (jobs[index] != null) {
              return applicationCard(
                  job: jobs[index],
                  status: snapshot.data.documents[index]['status']);
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text('job not found')),
              );
            }
          });
    }
  }

  Widget applicationCard({var job, String status}) {
    String organization = job['organization'];
    String title = job['title'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: const Icon(Icons.business),
          title: Text(organization),
          subtitle: Text(title),
          trailing: Text('status: $status'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewApplication(
                        job: job,
                        status: status,
                      )),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
