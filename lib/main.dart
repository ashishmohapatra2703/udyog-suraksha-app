import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/screens/about_screen.dart';
import 'package:iot_project/screens/iotscreen1.dart';
import 'package:iot_project/screens/iotscreen2.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              if (index >= 1)
                _selectedIndex = index - 1;
              else
                _selectedIndex = index;
            });
          },
          children: <Widget>[
            IotScreen1(),
            IotScreen2(),
            AboutScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Data'),
              textAlign: TextAlign.center,
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.info_outline),
              title: Text('About'),
              textAlign: TextAlign.center,
              activeColor: Colors.green,
            ),
          ],
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = (index >= 1) ? index - 1 : index;
              _pageController.animateToPage((index >= 1) ? index + 1 : index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            });
          },
        ),
      ),
    );
  }
}
