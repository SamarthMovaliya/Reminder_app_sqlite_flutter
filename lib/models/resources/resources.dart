import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DateTime dateTime = DateTime.now();
TimeOfDay selectedTime = TimeOfDay.now();
Color selectedColor = Colors.deepPurple.shade200;
List month = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
List week = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];
GlobalKey<FormState> globalKey = GlobalKey<FormState>();
String title = '';
String description = '';
DateTime savedTime = DateTime.now();
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
Color myPickedColor = Colors.amber.shade100;
Color currentColor = Colors.amber.shade100;
String myColor = '0xffb39ddb';
String myColor1 = '0xffb39ddb';

//
String st = '';
String sd = '';
int sid = 0;
String sc='';
String stt = '';
