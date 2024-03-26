import 'package:flutter/material.dart';

class NoteScreenController {
  static List notesList = [];

  static List<Color> colorConstant = [
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.grey
  ];

  static void addNote({
    required String title,
    required String des,
    required String date,
    required int colorIndex,
  }) {
    notesList.add(
        {"title": title, "dis": des, "date": date, "colorIndex": colorIndex});
  }

  static void delete(int index) {
    notesList.removeAt(index);
  }

  static void edit({
    required int index,
    required String title,
    required String des,
    required String date,
    required int colorIndex,
  }) {
    notesList[index] = {
      "title": title,
      "dis": des,
      "date": date,
      "colorIndex": colorIndex
    };
  }
}
