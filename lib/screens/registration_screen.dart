import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';

class ReregistrationScreen extends StatefulWidget {
  const ReregistrationScreen({Key key}) : super(key: key);

  @override
  _ReregistrationScreenState createState() => _ReregistrationScreenState();
}

Widget build(BuildContext context) {
  return const Scaffold(
    backgroundColor: Colors.white,
    body: ScreenContent(),
  );
}

class _ReregistrationScreenState extends State<ReregistrationScreen> {
  final _formkey = GlobalKey<FormState>();
  String disability;
  String gender;
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _cvcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 110, 0, 50),
              child: Image.network(
                'https://res.cloudinary.com/people-matters/image/upload/fl_immutable_cache,w_624,h_351,q_auto,f_auto/v1572535488/1572535486.jpg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _firstnamecontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _lastnamecontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailcontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _cvcontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CV Link',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _phonecontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _agecontroller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 8,
                  ),
                  child: Text("Disability:"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: DropdownButton(
                    value: disability,
                    icon: const Icon(Icons.arrow_downward),
                    isExpanded: false,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        disability = newValue;
                      });
                    },
                    items: <String>[
                      "Blindness",
                      "Low-vision",
                      "Leprosy Cured persons",
                      "Hearing Impairment",
                      "Locomotor Disability",
                      "Dwarfism",
                      "Intellectual Disability",
                      "Mental Illness",
                      "Autism Spectrum Disorder",
                      "Cerebral Palsy",
                      "Muscular Dystrophy",
                      "Chronic Neurological condition",
                      "Learning Disabilities",
                      "Multiple Sclerosis",
                      "Speech and Language disability",
                      "Thalassemia",
                      "Hemophilia",
                      "Sickle Cell disease",
                      "Acid Attack Survivor",
                      "Parkinson"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 8,
                  ),
                  child: Text("Gender:"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 11,
                  ),
                  child: DropdownButton(
                    value: gender,
                    icon: const Icon(Icons.arrow_downward),
                    isExpanded: false,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        gender = newValue;
                      });
                    },
                    items: <String>["Male", "Female"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(8),
                  ),
                  onPressed: () {
                    if (empty()) {
                      Fluttertoast.showToast(
                          msg:
                              "Please fill all data and enter correct email and password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1);
                    } else if (_passwordcontroller.text.length < 8) {
                      Fluttertoast.showToast(
                          msg: "Please password with more than 8 character's",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1);
                    } else {
                      signUp();
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.grey,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Log In? Tap me'),
            ),
          ]),
        ),
      ),
    );
  }

  bool empty() {
    if (_firstnamecontroller.text.isEmpty ||
        _lastnamecontroller.text.isEmpty ||
        _agecontroller.text.isEmpty ||
        _phonecontroller.text.isEmpty ||
        disability.isEmpty ||
        gender.isEmpty ||
        _cvcontroller.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void signUp() async {
    // here you write the codes to input the data into firestore
    var result = FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailcontroller.text.toString(),
            password: _passwordcontroller.text.toString())
        .whenComplete(() {
      final Future<FirebaseUser> user = auth.currentUser();
      final uid = user.then((value) => addData(value));
      // here you write the codes to input the data into firestore
    });
  }

  addData(FirebaseUser user) {
    final uid = user.uid;
    print(user.uid);
    if (uid.isNotEmpty) {
      user.sendEmailVerification();

      DocumentReference reference =
          Firestore.instance.collection("users").document(uid);
      reference.setData({
        'f_name': _firstnamecontroller.text.toString(),
        'l_name': _lastnamecontroller.text.toString(),
        'age': _agecontroller.text.toString(),
        'phone': _phonecontroller.text.toString(),
        'disability': disability.toString(),
        'gender': gender.toString(),
        'cv_link': _cvcontroller.text.toString()
      }).whenComplete(() {
        Fluttertoast.showToast(
            msg: "Account Created Please Check your Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        Navigator.pop(context);
        FirebaseAuth.instance.signOut();
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all th fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
      Navigator.pop(context);
    }
  }
}
