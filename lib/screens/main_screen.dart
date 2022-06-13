import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/screens/jobs_screen/search_screen.dart';
import 'package:wuzzuf_pwd/screens/post_job_screen.dart';
import 'package:wuzzuf_pwd/screens/profile_screen.dart';

import 'application_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Applications(),
    const SearchScreen(),
    const Profile(),
    const PostJob(),
  ];

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            label: 'Applications',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_sharp),
            label: 'Jobs',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos),
            label: 'Post Job',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
            backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
