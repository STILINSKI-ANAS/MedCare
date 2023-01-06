import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';
import '../../models/pill.dart';
import '../../utils/notifications.dart';

class SQLhelper{
  static DateTime stringToTimeOfDay(String tod) {
    // print(tod);
    final format = DateFormat.yMMMMd().add_Hm(); //"6:00 AM"
    return format.parse(tod);
  }

  static DateTime selectedDate = DateTime.now();
  static Future<void> _createTable(sql.Database database) async {
    await database.execute(
        '''
    CREATE TABLE Pill (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      time TEXT NOT NULL,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      dosage INTEGER NOT NULL,
      span INTEGER, 
      weight INTEGER NOT NULL
    )
    ''',
    );
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbremainder.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("..creating a table");
        await _createTable(database);
      },
    );
  }

  static Future<int> insertPill(Pill pill) async {
    final db = await SQLhelper.db();
    final id = await db.insert(
      'Pill',
      pill.toMap()
    );
    for(int i=0;i<pill.span;i++){
      await createNotification(pill.time.add(Duration(days: i)));
    }
    return id;
  }

  static Future<List<Pill>> getItems() async {
    final db = await SQLhelper.db();
    final List<Map<String, dynamic>> maps = await db.query('pill');
      return List.generate(maps.length, (i) {
        if (maps.length!=0){
          return Pill(
            id: maps[i]['id'],
            // time: maps[i]['time'],
            time: stringToTimeOfDay(maps[i]['time']),
            title: maps[i]['title'],
            description: maps[i]['description'],
            dosage: maps[i]['dosage'],
            span: maps[i]['span'],
            weight: maps[i]['weight'],
          );
        }else{
          return Pill(span: 0, id: 0, weight: 1, time: DateTime.now(), title: "Doli", description: "description", dosage: 1);
        }

      }
    );
  }

  static Future<void> deleteItem(Pill pill) async {
    final db = await SQLhelper.db();
    var id = pill.id;
    // var result = await db.rawQuery('SELECT id FROM Pill where ');
    try {
      await db.delete("Pill", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }


  static Future<int> getmaxId() async {
    final db = await SQLhelper.db();
    var result = await db.rawQuery('SELECT MAX(id) FROM Pill');
    print("object ${result.length}");
    if (result[0]['MAX(id)'] == null){
      return 0;
    } else{
      return result[0]['MAX(id)'] as int;
    }
  }

}


