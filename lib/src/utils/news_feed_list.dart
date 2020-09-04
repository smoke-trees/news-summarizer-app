enum NewsFeed {
  MOST_RECENT_STORIES,
  INDIA,
  WORLD,
}

const Map<NewsFeed, String> FeedUrlMap = {
  NewsFeed.MOST_RECENT_STORIES:
      "https://timesofindia.indiatimes.com/rssfeeds/1221656.cms",
  NewsFeed.INDIA:
      "https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms",
  NewsFeed.WORLD: "https://timesofindia.indiatimes.com/rssfeeds/296589292.cms",
};
