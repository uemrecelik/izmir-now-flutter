// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:izmirnow/componetns/FormButton.dart';
import 'package:izmirnow/screens/Register.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  // state will be use in future for send data of login activity
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => Center(child: CircularProgressIndicator())
      );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (ex) {
      // ignore: avoid_print this was for only development part,
      print(ex.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

///////////////////////////////// UI ////////////////// Login
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
              "Izmir Now,",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              "Sign in to continue!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E mail',
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5)),
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.mail,
                ),
              ),
            ),
            SizedBox(height: screenHeight * .025),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5)),
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.lock,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            FormButton(
              text: "Log In",
              onPressed: signIn,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>Register(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "I'm a new user, ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign Up",
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
