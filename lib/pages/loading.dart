// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:world_time/services/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setTime() async{
    WorldTime first = WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia/Kolkata');
    await first.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': first.location,
      'flag': first.flag,
      'time': first.time,
      'isDaytime': first.isDaytime,
    });

  }

  @override
  void initState() {
    super.initState();
    setTime();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.black,
          size: 50.0,
        ),
      ),

    );
  }
}

