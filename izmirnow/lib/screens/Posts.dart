import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:izmirnow/screens/CreatePost.dart';

import '../componetns/buildCard.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}
//var index = 0;
class _PostsState extends State<Posts> {

  QuerySnapshot? postSnapshot;
  getData() async{
    return await FirebaseFirestore.instance.collection("Posts").get();
  }



  void initState() {
    getData().then((result) {
      postSnapshot = result;
      setState(() {});
    });
    super.initState();
  }


Widget postList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 24),
        itemCount: postSnapshot!.docs.length,
        itemBuilder: (context, index) {
          return Post(
             title:postSnapshot!.docs[index].get('title'),description:postSnapshot!.docs[index].get('description'),date:postSnapshot!.docs[index].get('date'),imgUrl:postSnapshot!.docs[index].get('imgUrl'),location:postSnapshot!.docs[index].get('location')
          );
        },
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    if(postSnapshot == null) {
      return Container(
        child: Text("There is Something Wrong"),
      );

    }
    return Scaffold(
      body:Container(
        child: postList()
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePost()));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
