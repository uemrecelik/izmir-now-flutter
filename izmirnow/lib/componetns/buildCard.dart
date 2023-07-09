// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:izmirnow/screens/postDetails.dart';


class Post extends StatelessWidget {
 final title;
 final description;
 final date;
 final imgUrl;
 final location;

  const Post({super.key, required this.title, required this.description, required this.date, required this.imgUrl, required this.location});
 

  @override
  Widget build(BuildContext context) {
    var heading = title;
    var cardImage = NetworkImage(
        imgUrl);
    var supportingText =
        description;

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
            ),
            Container(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(supportingText.length > 75 ? '${supportingText.substring(0, 75)}...' : supportingText),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('Read More'),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20)
                      )
                    ),
                    context: context,
                     builder: (context) => postDetails(title:title,description:description,date:date,imgUrl:imgUrl,location:location),
                ))
              ],
            )
          ],
        ));
    
  }
}


