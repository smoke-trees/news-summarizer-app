class Article {
  String title;
  String description;
  String pubDate;
  String category;
  bool archived;
  int viewCount;
  String summary;
  String id;
  String link;

  Article(
      {this.id,
      this.title,
      this.archived,
      this.description,
      this.pubDate,
      this.category,
      this.viewCount,
      this.summary,
      this.link});

  factory Article.fromJson(json) {
    return Article(
        title: json["title"],
        description: json["description"],
        pubDate: json["pubDate"],
        category: json["category"],
        archived: json["archived"],
        viewCount: json["viewCount"],
        id: json["id"],
        summary: json["summary"],
        link: json["link"]);
  }
}
