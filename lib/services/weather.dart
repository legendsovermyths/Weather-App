import 'package:weatherapp/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screens/location_screen.dart';
import 'package:weatherapp/services/location.dart';
const String API='73497be81a4a69f0e94a0ba6b0335bc4';

class WeatherModel {
  double longitude;
  double latitude;
  Future<dynamic> getcityweather(String cityName) async{
    String url2='https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API&units=metric';
    Networking networking2=Networking(url: url2);
    var data=await networking2.getdata();
    return data;

  }
  Future<dynamic> getlocation() async {
    Location location = Location();
    await location.getlocation();
    longitude = location.longitude;
    latitude = location.latitude;
    Networking networking = Networking(
        url: 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$API&units=metric');
    var data = await networking.getdata();
    return data;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
