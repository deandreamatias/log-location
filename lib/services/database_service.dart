import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/log_location.dart';

class DatabaseService {
  Box<LogLocation> _box;
  StreamController<List<LogLocation>> _streamController =
      StreamController<List<LogLocation>>();

  Stream<List<LogLocation>> get listLocation => _streamController.stream;

  Future<void> init(String id) async {
    final Directory path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    try {
      Hive.registerAdapter(LogLocationAdapter());
    } catch (e) {
      debugPrint('Error to register adapter: $e');
    }
    _box = await Hive.openBox(id);
    _streamController.add(_box?.values?.toList());
  }

  Future<void> addLogLocation(LogLocation logLocation) async {
    await _box.put(logLocation.dateTime.toIso8601String(), logLocation);
    _streamController.add(_box?.values?.toList());
  }

  Future<void> clear() async {
    await _box.clear();
    _streamController.add(_box?.values?.toList());
  }

  Future<void> close() async {
    await _box.close();
  }
}
