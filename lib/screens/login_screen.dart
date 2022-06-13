import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuzzuf_pwd/screens/main_screen.dart';
import 'package:wuzzuf_pwd/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ScreenContent(),
    );
  }
}

class ScreenContent extends StatefulWidget {
  const ScreenContent({Key key}) : super(key: key);

  @override
  _ScreenContentState createState() => _ScreenContentState();
}

class _ScreenContentState extends State<ScreenContent> {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 120, 0, 50),
            child: Image.network(
              'https://res.cloudinary.com/people-matters/image/upload/fl_immutable_cache,w_624,h_351,q_auto,f_auto/v1572535488/1572535486.jpg',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 18),
            child: TextField(
                controller: mailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 50),
            child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 16),
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
                  logIn(mailController.text, passwordController.text);
                },
                child: const Text('Login'),
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
              if (mailController.text.toString().isNotEmpty) {
                FirebaseAuth.instance.sendPasswordResetEmail(
                    email: mailController.text.toString());
                Fluttertoast.showToast(
                    msg: "Check your Email",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
              } else {
                Fluttertoast.showToast(
                    msg: "Enter Your Email!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1);
              }
            },
            child: const Text('Forget password? Tap me!'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 25, 25, 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(8),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReregistrationScreen()));
                },
                child: const Text('No Account? Sign Up'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logIn(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        FirebaseAuth.instance.onAuthStateChanged.listen((user) {
          if (user != null) {
            Fluttertoast.showToast(
                msg: "Successful Login!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
          }
        });
      } catch (error) {
        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            Fluttertoast.showToast(
                msg: "Your email address appears to be malformed.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          case "ERROR_WRONG_PASSWORD":
            Fluttertoast.showToast(
                msg: "Your password is wrong.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          case "ERROR_USER_NOT_FOUND":
            Fluttertoast.showToast(
                msg: "User with this email doesn't exist.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          case "ERROR_USER_DISABLED":
            Fluttertoast.showToast(
                msg: "User with this email has been disabled.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            Fluttertoast.showToast(
                msg: "Too many requests. Try again later.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            Fluttertoast.showToast(
                msg: "Signing in with Email and Password is not enabled.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            break;
          default:
            Fluttertoast.showToast(
                msg: "An undefined Error happened.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Your Email And Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home");
  }
}
