import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Networking{
  Networking({@required this.url});
  String url;
  Future getdata() async{
    Response data=await get(url);
    if(data.statusCode==200){
      String candid=data.body ;
      return jsonDecode(candid);
    }
    else{
      print(data.statusCode);
    }
  }


}