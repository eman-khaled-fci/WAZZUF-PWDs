import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getUserid();
  }

  bool ready = false;
  String userid;
  String userName;

  getUserid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    userid = user.uid;
    getUserName();
  }

  getUserName() async {
    var user =
        await Firestore.instance.collection('users').document(userid).get();
    userName = user['f_name'];
    ready = true;
    if (mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: ready
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(
                      child: Image.network(
                          "https://storage.googleapis.com/glaze-ecom.appspot.com/images/D2Tz8-aFi/thumbs/watermark.png"),
                    ),
                    Center(
                      child: Text('Welcome, $userName',
                          style: const TextStyle(fontSize: 32)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: const Center(
                        child: Text(
                          "We're so happy you're here!",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Center(
                      child: Image.network(
                          "https://storage.googleapis.com/glaze-ecom.appspot.com/images/dsvImtjXe/thumbs/232.png"),
                    ),
                    const Center(
                      child: Text("Start Searching For Your Dream Job!",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
