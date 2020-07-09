// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogLocationAdapter extends TypeAdapter<LogLocation> {
  @override
  final typeId = 1;

  @override
  LogLocation read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogLocation(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      altitude: fields[2] as double,
      dateTime: fields[3] as DateTime,
      uid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogLocation obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.altitude)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.uid);
  }
}
