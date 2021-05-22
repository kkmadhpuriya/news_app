class NewsDataModel {
  final int id;
  final String author;
  final String title;
  final String description;
  final String url;

  NewsDataModel({this.id, this.author, this.title, this.description, this.url});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
    };
  }

  @override
  String toString() {
    return 'News{id: $id, author: $author, title: $title, description: $description, url: $url}';
  }
}
