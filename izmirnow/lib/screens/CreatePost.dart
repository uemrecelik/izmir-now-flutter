// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, avoid_print, unnecessary_new

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {


  

// For Images
late XFile selectedImage;
File? imageFile;
final ImagePicker _picker = ImagePicker();
String imageSelected = "";


Future getImage() async{
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  setState(() {
    selectedImage = image!;
    imageFile = File(selectedImage.path);
    imageSelected = "Image Selected";
  });

  print(imageFile);
  
}


  // For TextFilds
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

// For Date
 static final DateTime dateNow = DateTime.now();
// For Position
  Position? _position;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }


// Post Function
  Future <void> post() async{

 Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("postImages")
          .child("${randomAlphaNumeric(9)}.jpg");

try {
  await firebaseStorageRef.putFile(imageFile!);
} on FirebaseException catch (e) {
  print(e.message);
}

 final UploadTask task = firebaseStorageRef.putFile(imageFile!);
  var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error");
        }
        print(imageUrl);
      });
      print(_position);
        
    try{
        await FirebaseFirestore.instance.collection("Posts")
        .doc().set({
         'title': titleController.text.trim(),
         'description': descriptionController.text.trim(),  
         'imgUrl': imageUrl,
         'location': new GeoPoint(_position!.latitude, _position!.longitude),
         "date": dateNow,
    });
 
         Navigator.pop(context);
  } on FirebaseException catch(ex) {
   // ignore: avoid_print
   print(ex.message);
  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              FlatButton(
                  child: Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: getImage),
                  Text(imageSelected),
                   SizedBox(height: 30),
              TextField(
                controller: titleController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 30),
              FlatButton(
                  child: Text(
                    'Add Your Location',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: _getCurrentLocation),
              Text('Current Location: ' + _position.toString()),
              SizedBox(height: 70),
              FlatButton(
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: post),
            ],
          ),
        ),
      ),
    );
  }
}
