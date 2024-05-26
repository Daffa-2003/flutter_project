// ignore: file_names
import "dart:convert";

import 'package:flutter/material.dart';
import 'package:flutter_project/methods/api.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/pages/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void logout() async {
    final url = await OUT().postRequest(route: '/signout', data: {});
    final response = jsonDecode(url.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);

      setState(() {
        preferences.clear();
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'Coming Soon',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'User Page',
      style: TextStyle(fontSize: 24),
    ),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      logout();
    } else {
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
            icon: Icon(Icons.paste_rounded),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
