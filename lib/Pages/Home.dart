import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/Description.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/api_manager.dart';
import 'package:news_app/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Welcome> _newsModel;
  AuthMethod authMethod = new AuthMethod();

  void initState() {
    _newsModel = API_Manager().getsearchnews('all');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
        Container(
          child: FutureBuilder<Welcome>(
            future: _newsModel,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.articles.length,
                    itemBuilder: (context, index){
                    var article = snapshot.data!.articles[index];
                  if(index != 0){
                    return
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Description(article: article,)),
                          );
                        },
                        child: Container(
                        height: 140,
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
                            SizedBox(width: 26),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    article.title,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                      );
                  }else{
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Description(article:article)),
                          );
                        },
                        child:  Container(
                            margin: EdgeInsets.only(top: 0),
                          width: double.infinity,
                          child: Stack(children: [
                            Flexible(
                              child: Image.network(
                                    article.urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(article.title,
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                            )
                          ],)
                        ),
                      ),
                    );
                  }
                });
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
    );
  }

 Widget search() {
    return Column(children: [
      Text("hii")
    ],);
  }

}
