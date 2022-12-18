import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/src/widgets/framework.dart';
import 'package:mad/data.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  getName() {
    final id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) => {
              setState(() {
                name = value['firstName'];
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getName();
    super.initState();
  }

  int countNeutral = 0;
  int countHappy = 0;
  int countSad = 0;
  int countFearful = 0;
  int countDisgust = 0;
  int countAngry = 0;
  int countCalm = 0;
  int countSurprised = 0;
//  int countHappy = 0;
  final List<Data> totalData = [];

  getData() {
    for (int i = 0; i < data.length; i++) {
      if (data[i] == "Neutral") {
        countNeutral++;
      } else if (data[i] == 'Happy') {
        countHappy++;
      } else if (data[i] == 'Sad') {
        countSad++;
      } else if (data[i] == 'Fearful') {
        countFearful++;
      } else if (data[i] == 'Angry') {
        countAngry++;
      } else if (data[i] == 'Disgust') {
        countDisgust++;
      } else if (data[i] == 'Surprised') {
        countSurprised++;
      } else if (data[i] == 'Calm') {
        countCalm++;
      }
    }
    setState(() {
      totalData.add(
          Data(reaction: 'Neutral', count: countNeutral, color: Colors.green));
      totalData
          .add(Data(reaction: 'Happy', count: countHappy, color: Colors.blue));
      totalData
          .add(Data(reaction: 'Calm', count: countCalm, color: Colors.grey));
      totalData
          .add(Data(reaction: 'Sad', count: countSad, color: Colors.black));
      totalData
          .add(Data(reaction: 'Angry', count: countAngry, color: Colors.red));
      totalData.add(
          Data(reaction: 'Fearful', count: countFearful, color: Colors.cyan));
      totalData.add(
          Data(reaction: 'Disgust', count: countDisgust, color: Colors.amber));
      totalData.add(Data(
          reaction: 'Surprised', count: countSurprised, color: Colors.orange));
    });
  }

  List<charts.Series<Data, String>> _createdd() {
    return [
      charts.Series<Data, String>(
          id: 'Reactions',
          domainFn: (Data dd, _) => dd.reaction,
          measureFn: (Data dd, _) => dd.count,
          data: totalData,
          colorFn: (datum, index) => charts.MaterialPalette.black,
          labelAccessorFn: (Data dd, _) => dd.count.toString()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hello, ${name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'other',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          //height: height * 0.5,
          child: charts.BarChart(
            _createdd(),
            domainAxis: charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
            ),
            animate: false,
            barGroupingType: charts.BarGroupingType.grouped,
            barRendererDecorator: new charts.BarLabelDecorator<String>(),
            behaviors: [
              charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,
                outsideJustification: charts.OutsideJustification.middle,
                horizontalFirst: false,
                desiredMaxRows: 1,
                cellPadding:
                    EdgeInsets.only(top: 10, left: 50, right: 4.0, bottom: 4.0),
                entryTextStyle: const charts.TextStyleSpec(
                    color: charts.Color(r: 127, g: 63, b: 191), fontSize: 11),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  String reaction;
  int count;
  Color color;
  // final charts.Color color;

  Data({required this.reaction, required this.count, required this.color});
}
