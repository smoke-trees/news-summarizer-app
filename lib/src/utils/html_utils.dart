import 'package:html/parser.dart' show parse;

String getImageUrl(String description) {
  if (description != null) {
    var desc = parse(description);
    if (desc.getElementsByTagName("img").isEmpty) {
      return null;
    } else {
      return desc.getElementsByTagName("img")[0].attributes["src"];
    }
  } else {
    return "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2020/09/12/924561-kim-jong-un.jpg";
  }
}
