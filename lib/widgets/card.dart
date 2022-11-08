import 'dart:core';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NewWidgetCardHome extends StatelessWidget {
  var mediaQsize, mediaQheight, mediaQwidth;
  int capacity;
  int floor;
  int occupancy;
  NewWidgetCardHome({
    required this.capacity,
    required this.floor,
    required this.occupancy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.white,
      child: SizedBox(
        height: 80,
        width: 220,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 10,
              child: (floor == 0)
                  ? const Text('Ground Floor')
                  : (floor == 1)
                      ? const Text('1st Floor')
                      : (floor == 2)
                          ? const Text('2nd Floor')
                          : (floor == 3)
                              ? const Text('3rd Floor')
                              : const Text('4th Floor'),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: Text(
                  '${occupancy.toString()}/${capacity.toString()} offices Occupied'),
            ),
            // const Positioned(
            //   top: 60,
            //   left: 10,
            //   child: Text('3 offices Empty'),
            // ),
            Positioned(
              top: 10,
              left: 155,
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                animation: true,
                percent: occupancy / capacity,
                center: Text(
                  "${(occupancy / capacity * 100).round()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10.0),
                ),
                // footer: const Text(
                //   "Sales this week",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17.0),
                // ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
