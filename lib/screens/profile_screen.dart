import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/screens/edit_screen.dart';
import 'package:wuzzuf_pwd/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String age = '';
String disability = '';
String gender = '';
String phone = '';
String email = '';
String fName = '';
String lName = '';
String cvLink = '';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            onSelected: choiceAction,
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 34,
                              color: Colors.white,
                            ),
                            itemBuilder: (BuildContext context) {
                              return Constants.choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 130,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily: 'TextFont',
                                fontWeight: FontWeight.bold),
                            text: fName + ' ' + lName,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.link,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'cv_link',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: 180,
                                  height: 45,
                                  child: Text(cvLink,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'TextFont',
                                          fontWeight: FontWeight.bold)))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'E-mail',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(email,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'TextFont',
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.phone,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Icon(
                          //   Icons.person,
                          //   size: 40,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(phone,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'TextFont',
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.cake_rounded,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Icon(
                          //   Icons.person,
                          //   size: 40,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Age',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(age,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'TextFont',
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 30, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.male,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Gender',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(gender,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'TextFont',
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 30, 0, 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // border: Border.all(
                                //     color: Colors.grey, width: 2.0, style: BorderStyle.solid),
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.accessible,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Icon(
                          //   Icons.person,
                          //   size: 40,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Disability',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'TextFont',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(disability,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'TextFont',
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _onButtonPressed();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Edit(
                      age: age,
                      disability: disability,
                      gender: gender,
                      phone: phone,
                      fName: fName,
                      lName: lName,
                      cvLink: cvLink,
                    )),
          );
        },
        child: const Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot snap =
        await Firestore.instance.collection('users').document(user.uid).get();
    setState(() {
      cvLink = snap.data['cv_link'];
      email = user.email;
      age = snap.data['age'];
      disability = snap.data['disability'];
      fName = snap.data['f_name'];
      gender = snap.data['gender'];
      lName = snap.data['l_name'];
      phone = snap.data['phone'];
    });
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    print('signed out successfully');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void choiceAction(String choice) {
    //on clicking items in pop menu
    if (choice == Constants.signOut) {
      _signOut();
    }
    if (choice == Constants.delete) {
      _deleteFullAccount();
      _signOut();
    }
  }

  Future<void> _deleteFullAccount() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Future<FirebaseUser> user = auth.currentUser();
    user.then((value) => deleteData(value));
  }

  deleteData(FirebaseUser value) {
    value.delete();
  }
}

class Constants {
  static const String signOut = 'Sign Out';
  static const String delete = 'Delete Account';
  static const List<String> choices = <String>[signOut, delete];
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deleteUser(String email, String password) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      print(user);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user.uid)
          .deleteUser(); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future deleteUser() {
    return userCollection.document(uid).delete();
  }
}
