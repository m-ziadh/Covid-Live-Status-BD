import 'package:flutter/material.dart';
import 'covid_data.dart';

void main() => runApp(const Covid19Status());

class Covid19Status extends StatelessWidget {
  const Covid19Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Covid19 Status BD',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.lime,
                ),
              ),
            ),
          ),
          body: const CovidData(),
        ),
      ),
    );
  }
}
