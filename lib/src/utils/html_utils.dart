import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

String getImageUrl(String description) {
  var desc = parse(description);
  if (desc.getElementsByTagName("img").isEmpty) {
    return null;
  } else {
    return desc.getElementsByTagName("img")[0].attributes["src"];
  }
}
