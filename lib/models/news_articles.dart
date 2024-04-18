class NewsArticles{
  
  final String urlToImage;
  final String title;
  final String description;
  final String author;
  final String content;

  NewsArticles({
    required this.urlToImage,
    required this.title,
    required this.description,
    required this.author,
    required this.content,
  });

  factory NewsArticles.fromJson(Map<String, dynamic> json) {
    return NewsArticles(
     urlToImage: json['urlToImage']?? "",
      title: json['title']?? "",
      description: json['description']?? "",
      author: json['author']?? "",
      content: json['content']?? "",
    );
  }
}

