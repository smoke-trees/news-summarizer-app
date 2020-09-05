enum NewsFeed {
  MOST_RECENT_STORIES,
  INDIA,
  WORLD,
  NRI,
  BUSINESS,
  US,
  CRICKET,
  SPORTS,
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
};
