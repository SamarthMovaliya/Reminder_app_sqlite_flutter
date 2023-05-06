import 'package:flutter/material.dart';

class reminderModel {
  int id;
  String title;
  String description;
  String time;
  String color;

  reminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.color,
  });

  factory reminderModel.fromMap({required Map data}) {
    return reminderModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      time: data['time'],
      color: data['color'],
    );
  }
}
