enum ArticleType {
  NEWS,
  CUSTOM,
  EXPERT,
  PUB,
  AROUNDME,
}

extension ArticleTypeToEndpointExtension on ArticleType {
  String get endpointType {
    switch (this) {
      case ArticleType.NEWS:
        return 'news';
      case ArticleType.CUSTOM:
        return 'news';
      case ArticleType.AROUNDME:
        return 'news';
      case ArticleType.EXPERT:
        return 'expert';
      case ArticleType.PUB:
        return 'publication';
      default:
        return null;
    }
  }
}

ArticleType articleTypefromString(String type) {
  switch (type) {
    case "news":
      return ArticleType.NEWS;
    case "publication":
      return ArticleType.PUB;
    case "expert":
      return ArticleType.EXPERT;
  }
}

