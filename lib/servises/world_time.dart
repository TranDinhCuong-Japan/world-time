import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location namr for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url  fo api endpoint

  bool? isDayTime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make the request
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body) as Map;
      // print(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String utcOffset = data['utc_offset'];
      utcOffset = utcOffset.substring(1, 3);
      // print('$dateTime + $utcOffset');

      // Create datetime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(utcOffset)));
      // print(now);

      time = DateFormat.jm().format(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      // print('caught error : $e');
      time = 'could not get data';
    }
  }
}
