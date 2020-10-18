import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'progress_indicator.dart';

class Recently extends StatelessWidget {
  final List title = [
    "Maths",
    "Science",
    "Computer Science",
  ];

  final List titleImgLoc = [
    "Images/1.jpg",
    "Images/2.jpg",
    "Images/3.jpg",
  ];

  final List colors = [Colors.blue, Colors.black, Colors.green];

  @override
  Widget build(BuildContext context) {
    var rng = new math.Random.secure();
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  titleImgLoc[rng.nextInt(3)],
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                  offset: Offset(0.75, 0.95))
            ],
            color: Colors.grey),
        width: 85.0,
        height: 100,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title[rng.nextInt(3)],
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 14,
          ),
          FAProgressBar(
            size: 4,
            currentValue: 30,
            progressColor: Colors.green,
            backgroundColor: Color(0xffF0F0F0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "30% Completed",
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
