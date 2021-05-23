import 'package:flutter/material.dart';
import 'package:news_app/Models/NewsDataModel.dart';
import 'package:news_app/Models/NewsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class ListOfNews extends StatefulWidget {
  final Function callBackFunction;
  final List<NewsDataModel> news;

  const ListOfNews(
      {Key key, @required this.callBackFunction, @required this.news})
      : super(key: key);
  @override
  _ListOfNewsState createState() => _ListOfNewsState();
}

class _ListOfNewsState extends State<ListOfNews> {
  NewsModel _newsModel;

  @override
  void initState() {
    _newsModel = NewsModel();
    super.initState();
  }

  _launchURL(_url) async {
    try {
      await launch(_url);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var newsList = widget.news;

    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        NewsDataModel news = newsList[index];

        return Card(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: ListTile(
            onTap: () {
              _launchURL(news.url);
            },
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text('${news.title}'),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '${news.description}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'Author: ${news.author}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                deleteNews(news);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red[700],
              ),
            ),
          ),
        );
      },
    );
  }

  deleteNews(NewsDataModel news) async {
    await _newsModel.open();
    await _newsModel.deleteNews(news.id);
    widget.callBackFunction();
  }
}
