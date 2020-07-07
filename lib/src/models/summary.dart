class Summary {
  String url;
  String headline;
  String summary;

  Summary({this.url, this.headline, this.summary});

  Summary.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    headline = json['headline'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['headline'] = this.headline;
    data['summary'] = this.summary;
    return data;
  }
}