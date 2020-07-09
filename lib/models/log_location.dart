import 'package:hive/hive.dart';

part 'log_location.g.dart';

@HiveType(typeId: 1)
class LogLocation {
  LogLocation({
    this.latitude,
    this.longitude,
    this.altitude,
    this.dateTime,
    this.uid,
  });

  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final double altitude;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final String uid;
}
