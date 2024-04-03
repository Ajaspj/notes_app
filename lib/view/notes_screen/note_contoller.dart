import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteScreenController {
  static List notesListkeys = [];

  static List<Color> colorConstant = [
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.grey
  ];

  //hive ref
  static var myBox = Hive.box("notebox");

  static getinitKeys() {
    notesListkeys = myBox.keys.toList();
  }

  static Future<void> addNote({
    required String title,
    required String des,
    required String date,
    int colorIndex = 0,
  }) async {
    await myBox.add(
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
    notesListkeys = myBox.keys.toList();
  }

  static Future<void> delete(var key) async {
    await myBox.delete(key);
    notesListkeys = myBox.keys.toList();
  }

  static void edit({
    required var key,
    required String title,
    required String des,
    required String date,
    int colorIndex = 0,
  }) {
    myBox.put(key,
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
  }
}
