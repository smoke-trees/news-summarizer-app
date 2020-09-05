enum NewsFeed {
  MOST_RECENT_STORIES,
  INDIA,
  WORLD,
  NRI,
  BUSINESS,
  US,
  CRICKET,
  SPORTS,
  SCIENCE,
  ENVIRONMENT,
  TECH,
  EDUCATION,
  ENTERTAINMENT,
}

const Map<NewsFeed, String> FeedUrlMap = {
  NewsFeed.MOST_RECENT_STORIES:
      "https://timesofindia.indiatimes.com/rssfeeds/1221656.cms",
  NewsFeed.INDIA:
      "https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms",
  NewsFeed.WORLD: "https://timesofindia.indiatimes.com/rssfeeds/296589292.cms",
  NewsFeed.NRI: "https://timesofindia.indiatimes.com/rssfeeds/7098551.cms",
  NewsFeed.BUSINESS: "https://timesofindia.indiatimes.com/rssfeeds/1898055.cms",
  NewsFeed.US: "https://timesofindia.indiatimes.com/rssfeeds_us/72258322.cms",
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
};
