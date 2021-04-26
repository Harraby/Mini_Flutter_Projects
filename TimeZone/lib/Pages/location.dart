import 'package:flutter/material.dart';
import 'package:TimeZone/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

List<WorldTime> times = [
  WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin'),
  WorldTime(flag: 'tunisia.png', location: 'Sfax', url: 'Africa/Tunis'),
  WorldTime(flag: 'brazil.png', location: 'Sao Paulo', url: 'America/Sao_Paulo')
];

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    print('Build Function ran');

    void updateTime(index) async {
      WorldTime example = times[index];
      await example.getData();
      Navigator.pop(context, {
        'location': example.location,
        'time': example.time1,
        'flag': example.flag,
        'isDayTime': example.isDayTime
      });
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose a location'),
      ),
      body: ListView.builder(
        itemCount: times.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${times[index].flag}'),
                ),
                title: Text(times[index].location),
                onTap: () {
                  updateTime(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
