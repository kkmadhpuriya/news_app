import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsDataModel.dart';
import 'package:news_app/Models/NewsModel.dart';

class LoadNews extends StatefulWidget {
  final Function callBackFunction;

  const LoadNews({Key key, @required this.callBackFunction}) : super(key: key);

  @override
  _LoadNewsState createState() => _LoadNewsState();
}

class _LoadNewsState extends State<LoadNews> {
  var loading = true;
  NewsModel _newsModel;

  @override
  void initState() {
    super.initState();
    _newsModel = new NewsModel();
    loadData();
  }

  loadData() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2021-05-22&sortBy=popularity&apiKey=e9c1bd676b744f9ba20f32b9d3e09e30');
    var response = await http.get(url);
    var res = json.decode(response.body);
    // log(res.toString());

    await _newsModel.open();

    if (res['status'] == "ok") {
      res['articles'].forEach((article) {
        var newsRow = NewsDataModel(
          author: article['author'],
          title: article['title'],
          description: article['description'],
          url: article['url'],
        );
        _newsModel.insertNews(newsRow);
      });

      widget.callBackFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading News",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
