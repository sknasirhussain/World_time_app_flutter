// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:world_time/services/worldTime.dart';

class ChooseLocation extends StatefulWidget {

  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'Indonesia.png'),
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.png'),
  ];

  void updateTime(index) async{
    WorldTime first = locations[index];
    await first.getTime();

    //navogate to home screen after fetching
    Navigator.pop(context, {
      'location': first.location,
      'flag': first.flag,
      'time': first.time,
      'isDaytime': first.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build has been called");
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text("Choose a location"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
          itemBuilder: (context, index){
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal:4.0),
             child: Card(
               child: ListTile(
                 onTap: (){
                   updateTime(index);
                 },
                 title: Text(locations[index].location),
                 leading: CircleAvatar(
                   backgroundImage: AssetImage("assets/${locations[index].flag}"),
                 ),
               ),
             ),
           );
          },
      ),
    );
  }
}
