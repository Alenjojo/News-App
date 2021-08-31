import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:http/http.dart' as http;

import 'Description.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isSearching = true;
  TextEditingController searchtextEditingcontroller =
  new TextEditingController(text: 'all');
  late Future<Welcome> _newsModel;
  var newsModel;
  var search ='';

  @override
  void dispose() {
    searchtextEditingcontroller.dispose();
    super.dispose();
  }

  initiateSearch() {
    Future<Welcome> getsearchnews() async {
       search = searchtextEditingcontroller.text.trim();

      var client = http.Client();


      try{
        var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?q=$search&from=2021-08-30&to=2021-08-30&sortBy=popularity&apiKey=d5ffb9c7a7a946a6a2ad0c74b80c6810'));
        if(response.statusCode == 200){
          var jsonString = response.body;
          var jsonMap = jsonDecode(jsonString);
          setState(() {
            newsModel = Welcome.fromJson(jsonMap);
            _newsModel = newsModel;
          });
          isSearching = false;
        }else if(response.statusCode == 429){
          var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?q=$search&from=2021-08-30&to=2021-08-30&sortBy=popularity&apiKey=d5ffb9c7a7a946a6a2ad0c74b80c6810'));
          var jsonString = response.body;
          var jsonMap = jsonDecode(jsonString);
          newsModel = Welcome.fromJson(jsonMap);
        }
      } catch(Exception){
        print("$Exception");
        return newsModel;
      }
      return newsModel;
    }
   setState(() {
     _newsModel = getsearchnews();
   });
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  Widget searchList() {
    return Scaffold(
      body: FutureBuilder<Welcome>(
        future: _newsModel,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.articles.length,
                itemBuilder: (context, index){
                  var article = snapshot.data!.articles[index];
                    return
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Description(article: article,)),
                          );
                        },
                        child: Container(
                          height: 80,
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      article.urlToImage,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      article.title,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   article.description,
                                    //   maxLines: 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                });
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    onChanged: (val) {
                      initiateSearch();
                    },
                    controller: searchtextEditingcontroller,
                    decoration: InputDecoration(
                        hintText: "search", border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
        body: search != '' ? searchList() : Center(child: Text("Nothing to Show")),
      ),
    );
  }
}
