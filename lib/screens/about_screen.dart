import 'package:flutter/material.dart';
import 'package:iot_project/drawer.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' उद्योग सुरक्षा 1.0 ',
          style: TextStyle(
            fontSize: 29.0,
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                "COAL MINES WORKERS SAFETY MONITORING AND ALERTING",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF39FF14),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Text(
                  "Safety of Human and other resources is of the utmost importance in all professional workplaces, more so in underground coal mines. \n\nThis easy-to-use app is designed to monitor the working conditions inside a coal mine remotely. It is connected to an on-site IoT module that reads values from electronic sensor modules measuring Temperature, Humidity, Air Quality and Pressure in real-time. You can see all the real-time parameters in this app, set threshold ranges for possible dangerous conditions, get signal alerts if the thresholds are crossed and decide if the working conditions are unsafe without ever having to actually go into the mines. \n\nStay alert, Stay safe.",
                  textAlign: TextAlign.center,
                  maxLines: 100,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
