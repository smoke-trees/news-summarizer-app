// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiUserAdapter extends TypeAdapter<ApiUser> {
  @override
  final int typeId = 0;

  @override
  ApiUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiUser(
      email: fields[4] as String,
      name: fields[3] as String,
      blogPreferences: (fields[0] as List)?.cast<String>(),
      customPreferences: (fields[2] as List)?.cast<String>(),
      newsPreferences: (fields[1] as List)?.cast<String>(),
      fcmToken: fields[5] as String,
      photoUrl: fields[6] as String,
      firebaseUid: fields[7] as String,
      phoneNumber: fields[8] as String,
      latitude: fields[9] as double,
      longitude: fields[10] as double,
      notifEnabledPrefs: (fields[11] as List)?.cast<String>(),
      savedNewsIds: (fields[12] as List)?.cast<String>(),
      pubPreferences: (fields[15] as List)?.cast<String>(),
      savedBlogsIds: (fields[13] as List)?.cast<String>(),
      savedPubIds: (fields[14] as List)?.cast<String>(),
      completedOnboarding: fields[17] as bool,
      isUserLoggedIn: fields[16] as bool,
      forceRelogin: fields[18] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ApiUser obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.blogPreferences)
      ..writeByte(1)
      ..write(obj.newsPreferences)
      ..writeByte(2)
      ..write(obj.customPreferences)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.fcmToken)
      ..writeByte(6)
      ..write(obj.photoUrl)
      ..writeByte(7)
      ..write(obj.firebaseUid)
      ..writeByte(8)
      ..write(obj.phoneNumber)
      ..writeByte(9)
      ..write(obj.latitude)
      ..writeByte(10)
      ..write(obj.longitude)
      ..writeByte(11)
      ..write(obj.notifEnabledPrefs)
      ..writeByte(12)
      ..write(obj.savedNewsIds)
      ..writeByte(13)
      ..write(obj.savedBlogsIds)
      ..writeByte(14)
      ..write(obj.savedPubIds)
      ..writeByte(15)
      ..write(obj.pubPreferences)
      ..writeByte(16)
      ..write(obj.isUserLoggedIn)
      ..writeByte(17)
      ..write(obj.completedOnboarding)
      ..writeByte(18)
      ..write(obj.forceRelogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
