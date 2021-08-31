import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/api_manager.dart';
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
       search = searchtextEditingcontroller.text.trim();
    _newsModel = API_Manager().getsearchnews(search);
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
