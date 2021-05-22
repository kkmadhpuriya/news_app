import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/Components/ListOfNews.dart';
import 'package:news_app/Components/LoadNews.dart';
import 'package:news_app/Models/NewsDataModel.dart';
import 'package:news_app/Models/NewsModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsDataModel> news;
  NewsModel _newsModel;

  @override
  void initState() {
    _newsModel = new NewsModel();
    connectToDB();
    super.initState();
  }

  connectToDB() async {
    try {
      await _newsModel.open();
      List<NewsDataModel> newsList = await _newsModel.news();
      setState(() {
        news = newsList;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News APP"),
      ),
      body: news == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : news.length == 0
              ? LoadNews(
                  callBackFunction: connectToDB,
                )
              : ListOfNews(
                  callBackFunction: connectToDB,
                  news: news,
                ),
    );
  }
}
