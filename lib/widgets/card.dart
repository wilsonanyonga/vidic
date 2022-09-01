import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NewWidgetCardHome extends StatelessWidget {
  const NewWidgetCardHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.white,
      child: SizedBox(
        height: 80,
        width: 210,
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              left: 10,
              child: Text('1st Floor (10 offices)'),
            ),
            const Positioned(
              top: 40,
              left: 10,
              child: Text('7 offices Occupied'),
            ),
            // const Positioned(
            //   top: 60,
            //   left: 10,
            //   child: Text('3 offices Empty'),
            // ),
            Positioned(
              top: 10,
              left: 145,
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                animation: true,
                percent: 7 / 10,
                center: const Text(
                  "70.0%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
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
