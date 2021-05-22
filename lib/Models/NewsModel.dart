import 'package:news_app/Models/NewsDataModel.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'news';
final String id = 'id';
final String author = "author";
final String title = "title";
final String description = "description";
final String url = "url";

class NewsModel {
  Database db;

  Future open() async {
    String path = 'news.db';

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            create table $tableName ( 
              $id integer primary key autoincrement, 
              $author text not null,
              $title text not null,
              $description text not null,
              $url text not null)
            ''');
    });
  }

  Future<void> insertNews(NewsDataModel news) async {
    await db.insert(
      tableName,
      news.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsDataModel>> news() async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return NewsDataModel(
        id: maps[i]['id'],
        author: maps[i]['author'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        url: maps[i]['url'],
      );
    });
  }

  Future<void> deleteNews(int id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
