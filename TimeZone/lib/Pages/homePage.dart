import 'package:flutter/material.dart';
import 'loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: SafeArea(
          child: Column(
            children: [
              FlatButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data['location'] = result['location'];
                      data['url'] = result['url'];

                      data['isDayTime'] = result['isDayTime'];
                      data['time'] = result['time'];
                    });
                  },
                  icon: Icon(
                    Icons.local_airport,
                    color: Colors.red,
                  ),
                  label: Text('Edit location')),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        letterSpacing: 2.0),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                data['time'],
                style: TextStyle(fontSize: 50.0),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
