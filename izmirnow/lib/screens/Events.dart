import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:izmirnow/screens/CreatePost.dart';

import '../componetns/buildCard.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  QuerySnapshot? eventSnapshot;
  getData() async{
    return await FirebaseFirestore.instance.collection("Events").get();
  }

  void initState() {
    getData().then((result) {
      eventSnapshot = result;
      setState(() {});
    });
    super.initState();
  }


Widget postList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 24),
        itemCount: eventSnapshot!.docs.length,
        itemBuilder: (context, index) {
          return Post(
             title:eventSnapshot!.docs[index].get('title'),description:eventSnapshot!.docs[index].get('description'),date:eventSnapshot!.docs[index].get('date'),imgUrl:eventSnapshot!.docs[index].get('imgUrl'),location:eventSnapshot!.docs[index].get('location')
          );
        },
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    if(eventSnapshot == null) {
      return Container(
        child: Text("There is Something Wrong"),
      );

    }
    return Scaffold(
      backgroundColor: Colors.red,
      body:Container(
        child: postList()
      ),
    );
  }
}
