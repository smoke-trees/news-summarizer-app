class SummaryResponse {
  String url;
  String headline;
  String summary;
  String error;

  SummaryResponse({this.url, this.headline, this.summary});

  SummaryResponse.fromJson(Map<String, dynamic> json) {
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

  SummaryResponse.withError(this.error);
}