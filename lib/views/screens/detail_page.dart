import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controller/helper_class/database_helper.dart';
import 'package:reminder_app/controller/helper_class/notification_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../controller/theme_controller.dart';
import '../../models/resources/resources.dart';

class DetailPAge extends StatefulWidget {
  const DetailPAge({Key? key}) : super(key: key);

  @override
  State<DetailPAge> createState() => _DetailPAgeState();
}

class _DetailPAgeState extends State<DetailPAge> {
  DateTime savedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: const Icon(
              Icons.sunny,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'Add task',
                style: GoogleFonts.alata(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Title',
                      style: GoogleFonts.alata(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: titleController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Title";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        title = val!;
                      },
                      decoration: InputDecoration(
                        prefix: const SizedBox(
                          width: 10,
                        ),
                        hintText: 'Enter Title Here...',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                        labelText: 'Title',
                        suffixIcon: Icon(
                          Icons.title,
                          color: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade600
                              : Colors.grey.shade200,
                          size: 26,
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade400
                              : Colors.grey.shade200,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //description
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Description',
                      style: GoogleFonts.alata(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: descriptionController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Description";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        description = val!;
                      },
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        prefix: const SizedBox(
                          width: 10,
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintText: 'Enter Description Here...',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                        labelText: 'Description',
                        suffixIcon: Icon(
                          Icons.description,
                          color: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade600
                              : Colors.grey.shade200,
                          size: 26,
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade400
                              : Colors.grey.shade200,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //timePicker
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Time',
                      style: GoogleFonts.alata(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          setState(() {
                            savedTime = date;
                          });
                        }, onConfirm: (date) {});
                        // await showTimePicker(
                        //   minuteLabelText: 'Minute',
                        //   hourLabelText: "Hour",
                        //   routeSettings: const RouteSettings(name: 'Hello'),
                        //   context: context,
                        //   initialTime: selectedTime,
                        // ).then(
                        //   (value) => setState(
                        //     () {
                        //       selectedTime = value!;
                        //     },
                        //   ),
                        // );
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                (savedTime.hour < 12)
                                    ? Text(
                                        '${savedTime.hour}:${savedTime.minute} AM',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400,
                                          fontSize: 20,
                                        ),
                                      )
                                    : Text(
                                        '${savedTime.hour - 12}:${savedTime.minute} PM',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400,
                                          fontSize: 20,
                                        ),
                                      ),
                                const Spacer(),
                                Icon(
                                  Icons.timer_rounded,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple,
                            ),
                            child: const Text(
                              'Change Time',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //color scheme
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Text(
                      'Color Scheme',
                      style: GoogleFonts.alata(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: IconButton(
                            icon: const Icon(
                              Icons.color_lens_sharp,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Select Color',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: MaterialPicker(
                                      pickerColor: currentColor,
                                      onColorChanged: (Color val) {
                                        setState(() {
                                          currentColor = val;
                                          print('_________________________');
                                          String halfCode = currentColor
                                              .toString()
                                              .split('(')[1];
                                          String fullCode =
                                              halfCode.split(')')[0];
                                          myColor = fullCode;
                                          print(fullCode);
                                          print('_________________________');
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(int.parse(myColor)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          if (globalKey.currentState!.validate()) {
            globalKey.currentState!.save();
            print('_________________________________');
            print('_________________________________');
            print(savedTime);
            print('_________________________________');
            print('_________________________________');
            await DataBaseHelper.dataBaseHelper.insertData(
              Title: title,
              Description: description,
              Color: myColor,
              Time: savedTime.toString(),
            );
            Navigator.pop(context, 'HomePage');
            Navigator.pushReplacementNamed(context, 'HomePage');
            titleController.clear();
            descriptionController.clear();
          }
        },
        label: const Text(
          'Save',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.save,
          size: 20,
        ),
      ),
    );
  }
}
