import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';
import 'Constant.dart';

class API_Manager{
  Future<Welcome> getnews() async {
    var client = http.Client();
    var newsModel = null;

    try{
      var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=d5ffb9c7a7a946a6a2ad0c74b80c6810'));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        newsModel = Welcome.fromJson(jsonMap);
      }else if(response.statusCode == 429){
        var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=0912b3a1122a40a0b18acdf86c313a20'));
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