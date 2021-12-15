import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class CovidData extends StatefulWidget {
  const CovidData({Key? key}) : super(key: key);

  @override
  _CovidDataState createState() => _CovidDataState();
}

class _CovidDataState extends State<CovidData> {
  String LabTest = '0';
  String Confirmed = '0';
  String Isolation = '0';
  String Recovered = '0';
  String Death = '0';

  @override
  void initState() {
    pageLoad();
  }

  void pageLoad() async {
    final response = await http.Client()
        .get(Uri.parse('http://103.247.238.92/webportal/pages/covid19.php'));
    if (response.statusCode == 200) {
      var document = parse(response.body);

      var link = document.getElementsByClassName("info-box-number");

      //Latest
      LabTest = link.elementAt(6).text;
      Confirmed = link.elementAt(7).text;
      Isolation = link.elementAt(8).text;
      Recovered = link.elementAt(9).text;
      Death = link.elementAt(10).text;
    } else {
      throw Exception();
    }
  }

  //Retrun Data To Main App
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerBox(Data: LabTest, label: 'Lab Test', colour: Colors.indigoAccent,),
        Expanded(
          child: Row(
            children: [
              ContainerBox(Data: Confirmed, label: 'Confirmed', colour: Colors.deepOrange,),
              ContainerBox(Data: Isolation, label: 'Isolation', colour: Colors.teal,),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              ContainerBox(Data: Recovered, label: 'Recovered', colour: Colors.green,),
              ContainerBox(Data: Death, label: 'Death', colour: Colors.red,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            onPressed: () {
              setState(() {
                initState();
              });
            },
            child: Text('Check'),
          ),
        ),
      ],
    );
  }
}

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    Key? key,
    required this.Data,
    required this.label,
    required this.colour,
  }) : super(key: key);

  final String Data;
  final String label;
  final Color colour;
  final double ValueSize = 50.0;
  final double textSize = 20.0;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Data,
              style: TextStyle(
                fontSize: ValueSize,
                color: colour,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              label,
              style: TextStyle(
                fontSize: textSize,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
