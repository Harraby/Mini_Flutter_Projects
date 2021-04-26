import 'package:flutter/material.dart';
import 'package:TimeZone/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

String bgImage;

class _LoadingPageState extends State<LoadingPage> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');

    await instance.getData();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time1,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRotatingCircle(
      color: Colors.white,
      size: 60.0,
    );
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: spinkit,
      ),
    );
  }
}
