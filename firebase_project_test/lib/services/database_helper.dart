import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notification_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notification.db";

  Future<Database> initDB() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, _dbName);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async => await db.execute(
        'CREATE TABLE notification_message ('
        'id integer primary key autoincrement, '
        'title text, '
        'message text, '
        'topic text '
        ')',
      ),
    );
    return db;
  }

  static getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        'CREATE TABLE notification_message ('
        'id integer primary key autoincrement, '
        'title text, '
        'message text, '
        'topic text '
        ')',
      ),
      version: _version,
    );
  }

  static Future<int> addNotification(
      NotificationsModel notificationsModel) async {
    final db = await getDB();
    return await db.insert("Notification", notificationsModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNotification(
      NotificationsModel notificationsModel) async {
    final db = await getDB();
    return await db.update("Notification", notificationsModel.toMap(),
        where: "id = ?",
        whereArgs: [notificationsModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNotification(
      NotificationsModel notificationsModel) async {
    final db = await getDB();
    return await db.update(
      "Notification",
      notificationsModel.toMap(),
      where: "id = ?",
      whereArgs: [notificationsModel.id],
    );
  }

  static Future<List<NotificationsModel>?> getAllNotification() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query("Notification");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => NotificationsModel.fromJson((maps[0])));
  }
}
