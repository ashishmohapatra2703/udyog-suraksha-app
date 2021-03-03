import 'package:flutter/material.dart';
import 'package:iot_project/screens/about_screen.dart';
import 'package:iot_project/screens/iotscreen1.dart';
import 'package:iot_project/screens/iotscreen2.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            color: Colors.blue,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("icons/appstore.png"),
                    ),
                  ),
                ),
                Text(
                  'PD lab Group-4 IOT Project',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Location 1 - Data & Control'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IotScreen1(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Location 2 - Data & Control'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IotScreen2(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
