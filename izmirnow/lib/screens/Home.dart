// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:izmirnow/screens/Events.dart';
import 'package:izmirnow/screens/MapScreen.dart';
import 'package:izmirnow/screens/Posts.dart';
import 'package:izmirnow/screens/Profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(); 
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  pageController.animateToPage(index, duration: Duration(microseconds: 100), curve: Curves.bounceIn);
  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!),
      ),
      body: PageView(
        controller: pageController,
        children:  [
          Posts(),
          Events(),
          MapScreen(),
          Profile(),
        ],
      ),    
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 92, 160, 238),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 38, 0, 255),
        onTap: onTapped,
      ),
     
    );
    
  }
}






