import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';
import 'Constant.dart';

class API_Manager{
  Future<Welcome> getsearchnews(String search) async {
    var client = http.Client();
    var newsModel;

    try{
      var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?q=$search&from=2021-08-30&to=2021-08-30&sortBy=popularity&apiKey=d5ffb9c7a7a946a6a2ad0c74b80c6810'));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
          newsModel = Welcome.fromJson(jsonMap);
      }else{
        var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?q=$search&from=2021-08-30&to=2021-08-30&sortBy=popularity&apiKey=0912b3a1122a40a0b18acdf86c313a20'));
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