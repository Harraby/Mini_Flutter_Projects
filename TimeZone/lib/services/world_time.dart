import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  //location name for the ui
  String time;
  //time for the ui
  String flag;
  //url to an asset
  String url;
  //timezone/continent/country
  String time1;
  bool isDayTime;
  //true or false

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String time = data['datetime'];
      String offset = time.substring(27, 29);
      // print(time);
      //print(offset);
      DateTime now = DateTime.parse(time);
      now = now.add(Duration(hours: int.parse(offset)));
      //set the time property
      time = DateFormat.jm().format(now);
      //this works
      time1 = time;

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
    } catch (e) {
      print('World_time error: $e');
      time1 = 'Could not get data';
    }
  }
}
