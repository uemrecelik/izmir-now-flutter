// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);


  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser!;
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                children: [
                  Text(user.email!),
                  ElevatedButton(onPressed: signOut, child: Text("Log Out"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
