// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsFeedAdapter extends TypeAdapter<NewsFeed> {
  @override
  final int typeId = 1;

  @override
  NewsFeed read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return NewsFeed.INDIA;
      case 2:
        return NewsFeed.WORLD;
      case 3:
        return NewsFeed.NRI;
      case 4:
        return NewsFeed.BUSINESS;
      case 5:
        return NewsFeed.CRICKET;
      case 6:
        return NewsFeed.SPORTS;
      case 7:
        return NewsFeed.SCIENCE;
      case 8:
        return NewsFeed.ENVIRONMENT;
      case 9:
        return NewsFeed.TECH;
      case 10:
        return NewsFeed.EDUCATION;
      case 11:
        return NewsFeed.ENTERTAINMENT;
      case 12:
        return NewsFeed.LIFESTYLE;
      case 13:
        return NewsFeed.ASTROLOGY;
      case 14:
        return NewsFeed.AUTO;
      case 15:
        return NewsFeed.MUMBAI;
      case 16:
        return NewsFeed.DELHI;
      case 17:
        return NewsFeed.BANGALORE;
      case 18:
        return NewsFeed.HYDERABAD;
      case 19:
        return NewsFeed.CHENNAI;
      case 20:
        return NewsFeed.AHEMDABAD;
      case 21:
        return NewsFeed.ALLAHBAD;
      case 22:
        return NewsFeed.BHUBANESHWAR;
      case 23:
        return NewsFeed.COIMBATORE;
      case 24:
        return NewsFeed.GURGAON;
      case 25:
        return NewsFeed.GUWAHATI;
      case 26:
        return NewsFeed.HUBLI;
      case 27:
        return NewsFeed.KANPUR;
      case 28:
        return NewsFeed.KOLKATA;
      case 29:
        return NewsFeed.LUDHIANA;
      case 30:
        return NewsFeed.MANGALORE;
      case 31:
        return NewsFeed.MYSORE;
      case 32:
        return NewsFeed.NOIDA;
      case 33:
        return NewsFeed.PUNE;
      case 34:
        return NewsFeed.GOA;
      case 35:
        return NewsFeed.CHANDIGARH;
      case 36:
        return NewsFeed.LUCKNOW;
      case 37:
        return NewsFeed.PATNA;
      case 38:
        return NewsFeed.JAIPUR;
      case 39:
        return NewsFeed.NAGPUR;
      case 40:
        return NewsFeed.RAJKOT;
      case 41:
        return NewsFeed.RANCHI;
      case 42:
        return NewsFeed.SURAT;
      case 43:
        return NewsFeed.VADODARA;
      case 44:
        return NewsFeed.VARANASI;
      case 45:
        return NewsFeed.THANE;
      case 46:
        return NewsFeed.THIRUVANANTHAPURAM;
      case 47:
        return NewsFeed.USA;
      case 48:
        return NewsFeed.SOUTH_ASIA;
      case 49:
        return NewsFeed.UK;
      case 50:
        return NewsFeed.EUROPE;
      case 51:
        return NewsFeed.CHINA;
      case 52:
        return NewsFeed.MIDDLE_EAST;
      case 53:
        return NewsFeed.REST_OF_WORLD;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, NewsFeed obj) {
    switch (obj) {
      case NewsFeed.INDIA:
        writer.writeByte(1);
        break;
      case NewsFeed.WORLD:
        writer.writeByte(2);
        break;
      case NewsFeed.NRI:
        writer.writeByte(3);
        break;
      case NewsFeed.BUSINESS:
        writer.writeByte(4);
        break;
      case NewsFeed.CRICKET:
        writer.writeByte(5);
        break;
      case NewsFeed.SPORTS:
        writer.writeByte(6);
        break;
      case NewsFeed.SCIENCE:
        writer.writeByte(7);
        break;
      case NewsFeed.ENVIRONMENT:
        writer.writeByte(8);
        break;
      case NewsFeed.TECH:
        writer.writeByte(9);
        break;
      case NewsFeed.EDUCATION:
        writer.writeByte(10);
        break;
      case NewsFeed.ENTERTAINMENT:
        writer.writeByte(11);
        break;
      case NewsFeed.LIFESTYLE:
        writer.writeByte(12);
        break;
      case NewsFeed.ASTROLOGY:
        writer.writeByte(13);
        break;
      case NewsFeed.AUTO:
        writer.writeByte(14);
        break;
      case NewsFeed.MUMBAI:
        writer.writeByte(15);
        break;
      case NewsFeed.DELHI:
        writer.writeByte(16);
        break;
      case NewsFeed.BANGALORE:
        writer.writeByte(17);
        break;
      case NewsFeed.HYDERABAD:
        writer.writeByte(18);
        break;
      case NewsFeed.CHENNAI:
        writer.writeByte(19);
        break;
      case NewsFeed.AHEMDABAD:
        writer.writeByte(20);
        break;
      case NewsFeed.ALLAHBAD:
        writer.writeByte(21);
        break;
      case NewsFeed.BHUBANESHWAR:
        writer.writeByte(22);
        break;
      case NewsFeed.COIMBATORE:
        writer.writeByte(23);
        break;
      case NewsFeed.GURGAON:
        writer.writeByte(24);
        break;
      case NewsFeed.GUWAHATI:
        writer.writeByte(25);
        break;
      case NewsFeed.HUBLI:
        writer.writeByte(26);
        break;
      case NewsFeed.KANPUR:
        writer.writeByte(27);
        break;
      case NewsFeed.KOLKATA:
        writer.writeByte(28);
        break;
      case NewsFeed.LUDHIANA:
        writer.writeByte(29);
        break;
      case NewsFeed.MANGALORE:
        writer.writeByte(30);
        break;
      case NewsFeed.MYSORE:
        writer.writeByte(31);
        break;
      case NewsFeed.NOIDA:
        writer.writeByte(32);
        break;
      case NewsFeed.PUNE:
        writer.writeByte(33);
        break;
      case NewsFeed.GOA:
        writer.writeByte(34);
        break;
      case NewsFeed.CHANDIGARH:
        writer.writeByte(35);
        break;
      case NewsFeed.LUCKNOW:
        writer.writeByte(36);
        break;
      case NewsFeed.PATNA:
        writer.writeByte(37);
        break;
      case NewsFeed.JAIPUR:
        writer.writeByte(38);
        break;
      case NewsFeed.NAGPUR:
        writer.writeByte(39);
        break;
      case NewsFeed.RAJKOT:
        writer.writeByte(40);
        break;
      case NewsFeed.RANCHI:
        writer.writeByte(41);
        break;
      case NewsFeed.SURAT:
        writer.writeByte(42);
        break;
      case NewsFeed.VADODARA:
        writer.writeByte(43);
        break;
      case NewsFeed.VARANASI:
        writer.writeByte(44);
        break;
      case NewsFeed.THANE:
        writer.writeByte(45);
        break;
      case NewsFeed.THIRUVANANTHAPURAM:
        writer.writeByte(46);
        break;
      case NewsFeed.USA:
        writer.writeByte(47);
        break;
      case NewsFeed.SOUTH_ASIA:
        writer.writeByte(48);
        break;
      case NewsFeed.UK:
        writer.writeByte(49);
        break;
      case NewsFeed.EUROPE:
        writer.writeByte(50);
        break;
      case NewsFeed.CHINA:
        writer.writeByte(51);
        break;
      case NewsFeed.MIDDLE_EAST:
        writer.writeByte(52);
        break;
      case NewsFeed.REST_OF_WORLD:
        writer.writeByte(53);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsFeedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
