import 'dart:js_util';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Map data = {
  //   'time': 'Time',
  //   'location': 'Location',
  //   'isDaytime': true,
  //   'flag': 'location.png'
  // };
Map data ={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;


    //Set background image
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';

    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async {
                      dynamic resuft =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': resuft['time'],
                          'location': resuft['location'],
                          'isDaytime': resuft['isDaytime'],
                          'flag': resuft['flag'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit location',
                      style: TextStyle(color: Colors.grey[300]),
                    )),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 3.0,
                          color: Colors.grey[300]),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 60.0, color: Colors.grey[300]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
