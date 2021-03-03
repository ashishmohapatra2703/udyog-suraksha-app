import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iot_project/screens/alert_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:iot_project/drawer.dart';

class IotScreen2 extends StatefulWidget {
  @override
  IotScreen2State createState() => IotScreen2State();
}

class IotScreen2State extends State<IotScreen2>
    with AutomaticKeepAliveClientMixin {
  SfRangeValues tempRange = SfRangeValues(30.0, 38.0);
  SfRangeValues humidityRange = SfRangeValues(50.0, 68.0);
  SfRangeValues pressureRange = SfRangeValues(1.0, 1.3);
  SfRangeValues airQualityRange = SfRangeValues(1000.0, 2500.0);

  final _dbRef = FirebaseDatabase.instance.reference().child('Data2');

  double _temperature;
  double _humidity;
  double _pressure;
  double _airQuality;

  ScrollController _scrollController = ScrollController();

  Color getColour({double data, double lowerValue, double upperValue}) {
    if (data >= upperValue || data <= 0.0)
      return Colors.red;
    else if (data > lowerValue)
      return Colors.yellow;
    else if (data > 0.0)
      return Colors.green;
    else
      return Theme.of(context).primaryColor; // if (data == null)
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
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
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Scroll up to set the range of values (controlled in the yellow segement) to be handled by the mining engineer , in which the workers should be cautious and evacuate before any actual disaster happen ( i.e, in the right red segment values).",
                    textScaleFactor: 1.4,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        },
        mini: true,
        backgroundColor: Colors.green,
        foregroundColor: Color(0xFF28324B),
        child: Icon(Icons.accessibility_new),
      ),
      body: StreamBuilder(
        stream: _dbRef.onValue,
        builder: (context, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            DataSnapshot snapshot = snap.data.snapshot;
            _temperature = snapshot.value["Temperature"].toDouble();
            _humidity = snapshot.value["Humidity"].toDouble();
            _airQuality = snapshot.value["AirQuality"].toDouble();
            _pressure = (snapshot.value["Pressure"] / 1000).toDouble();

            if (_temperature >= tempRange.end.toDouble() ||
                _humidity >= humidityRange.end.toDouble() ||
                _airQuality >= airQualityRange.end.toDouble() ||
                _pressure >= pressureRange.end.toDouble()) //danger condition
            {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertWidget('Location 2');
                    });
              });
            }

            return SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 50),
                child: Column(
                  children: [
                    Text('Location 2'),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: getColour(
                              data: _temperature,
                              lowerValue: tempRange.start.toDouble(),
                              upperValue: tempRange.end.toDouble(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'TEMPERATURE 🌡️',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF06257A),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$_temperature °C',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: getColour(
                              data: _humidity,
                              lowerValue: humidityRange.start.toDouble(),
                              upperValue: humidityRange.end.toDouble(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'HUMIDITY 💦',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF06257A),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$_humidity %',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: getColour(
                              data: _pressure,
                              lowerValue: pressureRange.start.toDouble(),
                              upperValue: pressureRange.end.toDouble(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'PRESSURE 😰',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF06257A),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$_pressure bar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: getColour(
                              data: _airQuality,
                              lowerValue: airQualityRange.start.toDouble(),
                              upperValue: airQualityRange.end.toDouble(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'AIR QUALITY 😷',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF06257A),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$_airQuality ppm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text('Green => Safe',
                        style: TextStyle(color: Colors.green)),
                    Text('Yellow => Alert',
                        style: TextStyle(color: Colors.yellow)),
                    Text('Red => Danger', style: TextStyle(color: Colors.red)),
                    SizedBox(height: 18),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        /// Scroll maximum end, if you want you can give hardcoded values also in place of _scrollController.position.maxScrollExtent
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      },
                      child: Icon(
                        Icons.arrow_downward,
                        size: 40.0,
                      ),
                    ),
                    SizedBox(height: 100),
                    Text(
                      "Temperature Threshold Range of Alert (in °C)",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SfRangeSlider(
                      min: 0.0,
                      max: 60.0,
                      values: tempRange,
                      interval: 10.0,
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      minorTicksPerInterval: 1,
                      inactiveColor: Colors.red,
                      activeColor: Colors.yellow,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          tempRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Humidity Threshold Range of Alert (in %)",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SfRangeSlider(
                      min: 20.0,
                      max: 100.0,
                      values: humidityRange,
                      interval: 20.0,
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      minorTicksPerInterval: 1,
                      inactiveColor: Colors.red,
                      activeColor: Colors.yellow,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          humidityRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pressure Threshold Range of Alert (in bar)",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SfRangeSlider(
                      min: 0.4,
                      max: 2.0,
                      values: pressureRange,
                      interval: 0.2,
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      inactiveColor: Colors.red,
                      activeColor: Colors.yellow,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          pressureRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Air Quality Threshold Range of Alert (in ppm)",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SfRangeSlider(
                      min: 200.0,
                      max: 4700.0,
                      values: airQualityRange,
                      interval: 500.0,
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      minorTicksPerInterval: 1,
                      inactiveColor: Colors.red,
                      activeColor: Colors.yellow,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          airQualityRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 30.0),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        /// Scroll maximum end, if you want you can give hardcoded values also in place of _scrollController.position.maxScrollExtent
                        _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Icon(
                        Icons.arrow_upward,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
