enum NewsFeed {
  INDIA,
  WORLD,
  NRI,
  BUSINESS,
  CRICKET,
  SPORTS,
  SCIENCE,
  ENVIRONMENT,
  TECH,
  EDUCATION,
  ENTERTAINMENT,
  LIFESTYLE,
  ASTROLOGY,
  AUTO,
  MUMBAI,
  DELHI,
  BANGALORE,
  HYDERABAD,
  CHENNAI,
}

const Map<NewsFeed, String> FeedUrlMap = {
  NewsFeed.INDIA:
      "https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms",
  NewsFeed.WORLD: "https://timesofindia.indiatimes.com/rssfeeds/296589292.cms",
  NewsFeed.NRI: "https://timesofindia.indiatimes.com/rssfeeds/7098551.cms",
  NewsFeed.BUSINESS: "https://timesofindia.indiatimes.com/rssfeeds/1898055.cms",
  NewsFeed.CRICKET: "https://timesofindia.indiatimes.com/rssfeeds/54829575.cms",
  NewsFeed.SPORTS: "https://timesofindia.indiatimes.com/rssfeeds/4719148.cms",
  NewsFeed.SCIENCE:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128672765.cms",
  NewsFeed.ENVIRONMENT:
      "http://timesofindia.indiatimes.com/rssfeeds/2647163.cms",
  NewsFeed.TECH: "http://timesofindia.indiatimes.com/rssfeeds/66949542.cms",
  NewsFeed.EDUCATION:
      "http://timesofindia.indiatimes.com/rssfeeds/913168846.cms",
  NewsFeed.ENTERTAINMENT:
      "http://timesofindia.indiatimes.com/rssfeeds/1081479906.cms",
  NewsFeed.LIFESTYLE: "http://timesofindia.indiatimes.com/rssfeeds/2886704.cms",
  NewsFeed.ASTROLOGY:
      "https://timesofindia.indiatimes.com/rssfeeds/65857041.cms",
  NewsFeed.AUTO: "https://timesofindia.indiatimes.com/rssfeeds/74317216.cms",
  NewsFeed.MUMBAI:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128838597.cms",
  NewsFeed.DELHI: "http://timesofindia.indiatimes.com/rssfeeds/-2128839596.cms",
  NewsFeed.BANGALORE:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128833038.cms",
  NewsFeed.HYDERABAD:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128816011.cms",
  NewsFeed.CHENNAI: "http://timesofindia.indiatimes.com/rssfeeds/2950623.cms",
};
