import 'package:hive/hive.dart';

part 'news_feed_list.g.dart';

@HiveType(typeId: 1)
enum NewsFeed {
  @HiveField(1)
  INDIA,
  @HiveField(2)
  WORLD,
  @HiveField(3)
  NRI,
  @HiveField(4)
  BUSINESS,
  @HiveField(5)
  CRICKET,
  @HiveField(6)
  SPORTS,
  @HiveField(7)
  SCIENCE,
  @HiveField(8)
  ENVIRONMENT,
  @HiveField(9)
  TECH,
  @HiveField(10)
  EDUCATION,
  @HiveField(11)
  ENTERTAINMENT,
  @HiveField(12)
  LIFESTYLE,
  @HiveField(13)
  ASTROLOGY,
  @HiveField(14)
  AUTO,
  @HiveField(15)
  MUMBAI,
  @HiveField(16)
  DELHI,
  @HiveField(17)
  BANGALORE,
  @HiveField(18)
  HYDERABAD,
  @HiveField(19)
  CHENNAI,
  @HiveField(20)
  AHEMDABAD,
  @HiveField(21)
  ALLAHBAD,
  @HiveField(22)
  BHUBANESHWAR,
  @HiveField(23)
  COIMBATORE,
  @HiveField(24)
  GURGAON,
  @HiveField(25)
  GUWAHATI,
  @HiveField(26)
  HUBLI,
  @HiveField(27)
  KANPUR,
  @HiveField(28)
  KOLKATA,
  @HiveField(29)
  LUDHIANA,
  @HiveField(30)
  MANGALORE,
  @HiveField(31)
  MYSORE,
  @HiveField(32)
  NOIDA,
  @HiveField(33)
  PUNE,
  @HiveField(34)
  GOA,
  @HiveField(35)
  CHANDIGARH,
  @HiveField(36)
  LUCKNOW,
  @HiveField(37)
  PATNA,
  @HiveField(38)
  JAIPUR,
  @HiveField(39)
  NAGPUR,
  @HiveField(40)
  RAJKOT,
  @HiveField(41)
  RANCHI,
  @HiveField(42)
  SURAT,
  @HiveField(43)
  VADODARA,
  @HiveField(44)
  VARANASI,
  @HiveField(45)
  THANE,
  @HiveField(46)
  THIRUVANANTHAPURAM,
  @HiveField(47)
  USA,
  @HiveField(48)
  SOUTH_ASIA,
  @HiveField(49)
  UK,
  @HiveField(50)
  EUROPE,
  @HiveField(51)
  CHINA,
  @HiveField(52)
  MIDDLE_EAST,
  @HiveField(53)
  REST_OF_WORLD,
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
  NewsFeed.AHEMDABAD:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128821153.cms",
  NewsFeed.ALLAHBAD: "http://timesofindia.indiatimes.com/rssfeeds/3947060.cms",
  NewsFeed.BHUBANESHWAR:
      "http://timesofindia.indiatimes.com/rssfeeds/4118235.cms",
  NewsFeed.COIMBATORE:
      "http://timesofindia.indiatimes.com/rssfeeds/7503091.cms",
  NewsFeed.GURGAON: "http://timesofindia.indiatimes.com/rssfeeds/6547154.cms",
  NewsFeed.GUWAHATI: "http://timesofindia.indiatimes.com/rssfeeds/4118215.cms",
  NewsFeed.HUBLI: "http://timesofindia.indiatimes.com/rssfeeds/3942695.cms",
  NewsFeed.KANPUR: "http://timesofindia.indiatimes.com/rssfeeds/3947067.cms",
  NewsFeed.KOLKATA:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128830821.cms",
  NewsFeed.LUDHIANA: "http://timesofindia.indiatimes.com/rssfeeds/3947051.cms",
  NewsFeed.MANGALORE: "http://timesofindia.indiatimes.com/rssfeeds/3942690.cms",
  NewsFeed.MYSORE: "http://timesofindia.indiatimes.com/rssfeeds/3942693.cms",
  NewsFeed.NOIDA: "http://timesofindia.indiatimes.com/rssfeeds/8021716.cms",
  NewsFeed.PUNE: "http://timesofindia.indiatimes.com/rssfeeds/-2128821991.cms",
  NewsFeed.GOA: "http://timesofindia.indiatimes.com/rssfeeds/3012535.cms",
  NewsFeed.CHANDIGARH:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128816762.cms",
  NewsFeed.LUCKNOW:
      "http://timesofindia.indiatimes.com/rssfeeds/-2128819658.cms",
  NewsFeed.PATNA: "http://timesofindia.indiatimes.com/rssfeeds/-2128817995.cms",
  NewsFeed.JAIPUR: "http://timesofindia.indiatimes.com/rssfeeds/3012544.cms",
  NewsFeed.NAGPUR: "http://timesofindia.indiatimes.com/rssfeeds/442002.cms",
  NewsFeed.RAJKOT: "http://timesofindia.indiatimes.com/rssfeeds/3942663.cms",
  NewsFeed.RANCHI: "http://timesofindia.indiatimes.com/rssfeeds/4118245.cms",
  NewsFeed.SURAT: "http://timesofindia.indiatimes.com/rssfeeds/3942660.cms",
  NewsFeed.VADODARA: "http://timesofindia.indiatimes.com/rssfeeds/3942666.cms",
  NewsFeed.VARANASI: "http://timesofindia.indiatimes.com/rssfeeds/3947071.cms",
  NewsFeed.THANE: "http://timesofindia.indiatimes.com/rssfeeds/3831863.cms",
  NewsFeed.THIRUVANANTHAPURAM:
      "http://timesofindia.indiatimes.com/rssfeeds/878156304.cms",
  NewsFeed.USA: "http://timesofindia.indiatimes.com/rssfeeds/30359486.cms",
  NewsFeed.SOUTH_ASIA:
      "http://timesofindia.indiatimes.com/rssfeeds/3907412.cms",
  NewsFeed.UK: "http://timesofindia.indiatimes.com/rssfeeds/2177298.cms",
  NewsFeed.EUROPE: "http://timesofindia.indiatimes.com/rssfeeds/1898274.cms",
  NewsFeed.CHINA: "http://timesofindia.indiatimes.com/rssfeeds/1898184.cms",
  NewsFeed.MIDDLE_EAST:
      "http://timesofindia.indiatimes.com/rssfeeds/1898272.cms",
  NewsFeed.REST_OF_WORLD:
      "http://timesofindia.indiatimes.com/rssfeeds/671314.cms",
};
