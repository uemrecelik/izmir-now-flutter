// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class postDetails extends StatelessWidget {
  final date;

  final description;

  final imgUrl;

  final location;

  final title;

  const postDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.imgUrl,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            height: 200.0,
            child: Ink.image(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(description),
          ),
          Container(
            child: Row(
              children: [
                Icon(Icons.calendar_month),
                Text((date.toDate().toString()))
              ],
            ),
          ),
          Container(),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 200,
            child: Container(
              child: FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(location.latitude,location.longitude),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: latLng.LatLng(location.latitude,location.longitude),
                        builder: (ctx) => Container(
                          child: Icon(Icons.add_location),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
