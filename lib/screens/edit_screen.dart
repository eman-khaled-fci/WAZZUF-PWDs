import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/screens/main_screen.dart';
import 'package:wuzzuf_pwd/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Edit extends StatefulWidget {
  String age;
  String disability;
  String gender;
  String phone;
  String fName;
  String lName;
  String cvLink;

  Edit(
      {Key key,
      this.age,
      this.disability,
      this.gender,
      this.phone,
      this.fName,
      this.lName,
      this.cvLink})
      : super(key: key);

  @override
  _EditState createState() =>
      _EditState(age, disability, gender, phone, fName, lName, cvLink);
}

class _EditState extends State<Edit> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final genderController = TextEditingController();
  final disabilityController = TextEditingController();
  final ageController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final phoneController = TextEditingController();
  final cvlinkController = TextEditingController();
  String age;
  String disability;
  String gender;
  String phone;
  String value;
  String fName;
  String lName;
  String cvLink;

  _EditState(this.age, this.disability, this.gender, this.phone, this.fName,
      this.lName, this.cvLink);

  @override
  void initState() {
    super.initState();
    fnameController.text = fName;
    lnameController.text = lName;
    phoneController.text = phone;
    ageController.text = age;
    genderController.text = gender;
    disabilityController.text = disability;
    cvlinkController.text = cvLink;
    genderController.addListener(_printGender);
    disabilityController.addListener(_printDisability);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    genderController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    disabilityController.dispose();
    cvlinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile Data"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: cvlinkController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.link,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'cv_link',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,

                      fontSize: 18,

                      color: Color(0xFF2196F3),

                      // color: Color(0xFF6200EE),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: fnameController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: lnameController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: phoneController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'Phone',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: ageController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.cake,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'Age',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: disabilityController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.accessible,
                      color: Color(0xFF2196F3),
                    ),
                    labelText: 'Disability',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    suffixIcon: PopupMenuButton(
                      onSelected: choiceActionToEdit,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                        color: Color(0xFF2196F3),
                      ),
                      itemBuilder: (BuildContext context) {
                        return Constants.disabilities.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: TextFormField(
                  controller: genderController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 40,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.female,
                      color: Color(0xFF2196F3),
                    ),
                    suffixIcon: PopupMenuButton(
                      onSelected: choiceActionToEdit,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                        color: Color(0xFF2196F3),
                      ),
                      itemBuilder: (BuildContext context) {
                        return Constants.gender.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                    labelText: 'Gender',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2196F3),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 50.0,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 1,
                        offset: const Offset(10, 10),
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: const BorderSide(
                            color: Color.fromRGBO(0, 160, 227, 1))),
                    onPressed: () {
                      updateUserData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: SizedBox(
                              width: 200,
                              height: 16,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    "Done",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          backgroundColor: Colors.black));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      );
                    },
                    padding: const EdgeInsets.all(10.0),
                    color: const Color.fromRGBO(0, 160, 227, 1),
                    textColor: Colors.white,
                    child: Text("Edit".toUpperCase(),
                        style: const TextStyle(fontSize: 15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceActionToEdit(String choice) {
    //on clicking items in pop menu
    setState(() {
      gender = choice;
      disability = choice;
    });
    print(gender);
    print(disability);
  }

  void _printGender() {
    genderController.text = gender;
  }

  void _printDisability() {
    disabilityController.text = disability;
  }

  Future updateUserData() async {
    age = ageController.text.toString();
    disability = disabilityController.text.toString();
    fName = fnameController.text.toString();
    gender = genderController.text.toString();
    lName = lnameController.text.toString();
    phone = phoneController.text.toString();
    cvLink = cvlinkController.text.toString();
    final FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance
        .collection('users')
        .document(user.uid)
        .setData({
      'age': age,
      'disability': disability,
      'f_name': fName,
      'gender': gender,
      'l_name': lName,
      'phone': phone,
      'cv_link': cvLink
    });
  }
}

class Constants {
  static const String logout = 'Sign Out';
  static const String delete = 'Delete Account';
  static const String male = 'Male';
  static const String female = 'Female';

  static const String disability1 = 'Blindness ';
  static const String disability2 = ' Leprosy Cured persons ';
  static const String disability3 = 'Hearing Impairment';
  static const String disability4 = ' Locomotor Disability ';
  static const String disability5 = 'Dwarfism ';
  static const String disability6 = 'Intellectual Disability ';
  static const String disability7 = 'Mental Illness ';
  static const String disability8 = 'Autism Spectrum Disorder';
  static const String disability9 = ' Cerebral Palsy';
  static const String disability10 = ' Muscular Dystrophy ';
  static const String disability11 = 'Chronic Neurological condition';
  static const String disability12 = ' Learning Disabilities';
  static const String disability13 = ' Multiple Sclerosis ';
  static const String disability14 = 'Speech and Language disability ';
  static const String disability15 = 'Thalassemia ';
  static const String disability16 = 'Hemophilia ';
  static const String disability17 = 'Sickle Cell disease ';
  static const String disability18 = 'Acid Attack Survivor ';
  static const String disability19 = 'Parkinson';
  static const String disability20 = 'Low-vision';
  static const List<String> choices = <String>[logout, delete];
  static const List<String> gender = <String>[male, female];
  static const List<String> disabilities = <String>[
    'Blindness ',
    'Low-vision',
    ' Leprosy Cured persons ',
    'Hearing Impairment ',
    'Locomotor Disability',
    ' Dwarfism ',
    'Intellectual Disability',
    ' Mental Illness ',
    'Autism Spectrum Disorder',
    ' Cerebral Palsy',
    ' Muscular Dystrophy',
    ' Chronic Neurological condition',
    ' Learning Disabilities ',
    'Multiple Sclerosis ',
    'Speech and Language disability',
    ' Thalassemia',
    ' Hemophilia',
    ' Sickle Cell disease',
    ' Acid Attack Survivor',
    ' Parkinson'
  ];
}
