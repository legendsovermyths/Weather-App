import 'package:weatherapp/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/services/weather.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationweather);
  final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model=WeatherModel();
  String message;
  int temperature;
  int condition;
  String cityName;
  String weatheremoji;
  void updateUI(weatherdata){

    setState(() {
      if (weatherdata==null){
        message="unable to get the weather";
        temperature=0;
        cityName="";
        return;

      }
      double temp=weatherdata['main']['temp'].toDouble();
      temperature=temp.toInt();
      condition=weatherdata['weather'][0]['id'];
      cityName= weatherdata['name'];
      weatheremoji=model.getWeatherIcon(condition);
      message=model.getMessage(temperature);
    });
  }
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var data=await model.getlocation();
                      updateUI(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: (
                        ) async{
                      var cityName= await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (cityName!=null){
                        var weatherdata2=await model.getcityweather(cityName);
                        updateUI(weatherdata2);

                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatheremoji️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//double temperature=data['main']['temp'];
//int condition=data['weather'][0][id];
//String cityName= data['name'];