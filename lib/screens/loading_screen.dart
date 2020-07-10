import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather.dart';
import 'package:weatherapp/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel model=WeatherModel();

  @override
  void initState() {
    super.initState();
    getlocation();

  }
  void getlocation() async{
    var data= await WeatherModel().getlocation();
    Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(data);}
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
        ),
      ),
    );

  }
}