import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';
import 'Constant.dart';

class API_Manager{
  Future<Welcome> getnews() async {
    var client = http.Client();
    var newsModel = null;

    try{
      var response = await client.get(Uri.parse(Strings.news_url));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        newsModel = Welcome.fromJson(jsonMap);
      }
    } catch(Exception){
      return newsModel;
    }
    return newsModel;
  }
}