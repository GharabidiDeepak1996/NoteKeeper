
import 'package:floor/floor.dart';
import 'dao.dart';
import 'entity.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';
@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
 NoteDao get personDao;

}