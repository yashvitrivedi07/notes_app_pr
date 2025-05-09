import 'dart:developer';

import 'package:flutter_application_1/modal/note_modal.dart';
import 'package:sqflite/sqflite.dart';

class NoteHelper {
  NoteHelper._();
  static NoteHelper nh = NoteHelper._();

  Database? database;

  String tableName = "notesTable";
  String noteId = "id";
  String noteTitle = "title";
  String noteDescription = "description";
  String noteDate = "date";
  String noteTime = "time";

  Future<void> initDataBase() async {
    String? path = await getDatabasesPath();
    String? fpath = "${path}notes.db";

    database = await openDatabase(
      fpath,
      version: 1,
      onCreate: (db, version) {
        String q = '''CREATE TABLE $tableName (
        $noteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $noteTitle TEXT NOT NULL,
        $noteDescription TEXT NOT NULL,
        $noteDate TEXT NOT NULL,
        $noteTime TEXT NOT NULL
        )''';
        db
            .execute(q)
            .then(
              (value) => log("created"),
            )
            .onError(
              (error, stackTrace) => log("$error"),
            );
      },
    );
  }

  Future<int?> addData(NoteModal modal) async {
    await initDataBase();
    String q =
        "INSERT INTO $tableName ($noteTitle, $noteDescription, $noteDate, $noteTime) VALUES (?, ?, ?, ?)";
    List l = [modal.title, modal.description, modal.date, modal.title];
    return await database?.rawInsert(q, l);
  }

  Future<List<NoteModal>> fetchData() async {
    await initDataBase();
    List<Map<String, Object?>>? data = await database?.query(tableName);
    return data!
        .map(
          (e) => NoteModal.toModel(e),
        )
        .toList();
  }

  Future<int?> updateData(NoteModal modal) async {
  if (database == null) await initDataBase();

  String q =
      "UPDATE $tableName SET $noteTitle = ?, $noteDescription = ?, $noteDate = ?, $noteTime = ? WHERE $noteId = ?";
  List v = [
    modal.title,
    modal.description,
    modal.date,
    modal.time,
    modal.id, 
  ];

  return await database?.rawUpdate(q, v);
}

  Future<int?> deleteData(int id) async {
    if (database == null) await initDataBase();
    String q = "DELETE FROM $tableName WHERE $noteId = $id";
    return await database?.rawDelete(q);
  }

}
