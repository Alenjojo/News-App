import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/Description.dart';
import 'package:news_app/auth/NewUser.dart';
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
    _newsModel = API_Manager().getnews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Column(children: [
      //   FloatingActionButton(onPressed: (){
      //     final snackBar = SnackBar(content: Text('Signed Out'));
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //     authMethod.signOut();
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => FirstView()),
      //     );
      //   },),
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
                            SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    article.title,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 18,
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
                  }else{
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Description(article: article,)),
                          );
                        },
                        child:  SizedBox(
                          width: 200,
                          height: 350,
                          child: Stack(children: [
                            Flexible(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Hero(
                                    tag: article.urlToImage,
                                    child: Image.network(
                                      article.urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Text(article.title,
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              ),
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
      // ],)
    );
  }

 Widget search() {
    return Column(children: [
      Text("hii")
    ],);
  }

}
