// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:izmirnow/componetns/FormButton.dart';
import '../main.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();

Future signUp() async {
      showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator())
      );

  try{
 await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text.trim(),
     password: _passwordController.text.trim(),);
  } on FirebaseAuthException catch(ex) {
   // ignore: avoid_print
   print(ex.message);
  }
  await FirebaseFirestore.instance.collection("Users")
    .doc().set({
      'username': _usernameController.text.trim(),
      'email': _emailController.text.trim(),    
    });

  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}



///////////////////////////// UI ///////////////// Register
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              "Create Account,",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              "Sign up to get started!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            TextFormField(
             controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: 'Invalid password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.person,
                ),
              ),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
             controller: _emailController,
             autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'E mail',
                errorText: 'Invalid password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.mail,
                ),
              ),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
             controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: 'Invalid password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: "Sign Up",
              onPressed: signUp,
            ),
            SizedBox(
              height: screenHeight * .125,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: const TextSpan(
                  text: "I'm already a member, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}