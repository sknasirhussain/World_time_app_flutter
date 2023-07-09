import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location = ''; //loacation name for the ui
  String time = '';// the time in that location
  String flag = ''; // url to asset to flag image
  String url = ''; //location url for api endpoints that will be updated everytime
  bool isDaytime = true; //true or false if daytime or not

  //creating the constrictor to update all the values initialised above
  WorldTime({required this.location, required this.flag, required this.url}){}

  Future<void> getTime() async {

    try {
      //make the request to get the time data
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //get the properties needed for the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      //extract the hours and minutes
      int hours  = int.parse(offset.substring(1,3));
      int minutes = int.parse(offset.substring(4,6));

      //create a duration type object to make use of the parsed hours and minutes
      Duration offsetTime = Duration(hours: hours, minutes: minutes);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(offsetTime);

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch (e) {
      print('caught an error: $e');
      time = 'cannot get time at this moment :(';
    }

  }

}

