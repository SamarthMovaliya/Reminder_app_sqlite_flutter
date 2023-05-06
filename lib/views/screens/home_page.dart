import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controller/helper_class/database_helper.dart';
import 'package:reminder_app/views/screens/reminder_model.dart';

import '../../controller/helper_class/notification_helper.dart';
import '../../controller/theme_controller.dart';
import '../../models/resources/resources.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime ddd = DateTime.now();
  Future? storedData;

  @override
  void initState() {
    storedData = DataBaseHelper.dataBaseHelper.initDB();
    storedData = DataBaseHelper.dataBaseHelper.fetchAllRecode();
    NotificationHelper.notificationHelper.NotificationInitialize();
    String dd = ddd.toString();
    print(dd);
    DateTime? ds = DateTime.tryParse(dd);
    print(ds);
    print(ds!.hour);
    print(ds.microsecond);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_rounded,
          size: 30,
        ),
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
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: (Provider.of<ThemeProvider>(context).themeModal.isDark ==
                      false)
                  ? Colors.white
                  : Colors.grey.shade800,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextField(
                        onChanged: (val) {},
                        decoration: InputDecoration(
                          filled: true,
                          prefix: const SizedBox(
                            width: 10,
                          ),
                          hintText: 'Search',
                          suffixIcon: Icon(
                            Icons.search_rounded,
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
                            fontSize: 14,
                            color: (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Colors.grey.shade600
                                : Colors.grey.shade200,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                          fillColor: (Provider.of<ThemeProvider>(context)
                                      .themeModal
                                      .isDark ==
                                  false)
                              ? Colors.grey.shade200
                              : Colors.grey.shade700,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Reminder App',
                      style: GoogleFonts.robotoFlex(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          '${month[dateTime.month - 1]} ${dateTime.day},${dateTime.year}',
                          style: GoogleFonts.robotoFlex(
                            fontSize: 18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: Text(
                            '${week[dateTime.weekday - 1]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, right: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Reminders',
                      style: GoogleFonts.robotoFlex(
                        fontSize: 22,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: DataBaseHelper.dataBaseHelper.fetchAllRecode(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error :${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<reminderModel> allData =
                      snapshot.data as List<reminderModel>;
                  if (allData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_clock,
                            size: 300,
                            color: Colors.grey.shade300,
                          ),
                          Text(
                            'No Task Exists',
                            style: GoogleFonts.alata(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        allData[index].time;
                        DataBaseHelper.dataBaseHelper
                            .dummy(id: allData[index].id);
                        DateTime t = DateTime.parse(allData[index].time);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            color: Color(
                              int.parse(allData[index].color),
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              leading: Text(
                                '${index + 1})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              title: Text(
                                allData[index].title,
                                style: const TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allData[index].description,
                                    style: GoogleFonts.robotoFlex(
                                      letterSpacing: 0.3,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  (t.hour > 12)
                                      ? Text(
                                          '⏰ ${t.hour - 12} :${t.minute} PM',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      : Text(
                                          '⏰ ${t.hour} :${t.minute} AM',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                ],
                              ),
                              trailing: SizedBox(
                                height: 300,
                                width: 97,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 0,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            width: 0.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          currentColor = Color(
                                              int.parse(allData[index].color));
                                          myColor1 = allData[index].color;
                                        });
                                        Navigator.pushNamed(
                                          context,
                                          'updatePage',
                                          arguments: allData[index],
                                        );
                                        st = allData[index].title;
                                        sid = allData[index].id;
                                        sd = allData[index].description;
                                        stt = allData[index].time;
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 25,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await DataBaseHelper.dataBaseHelper
                                            .deleteData(
                                          id: allData[index].id,
                                        );
                                        setState(() {
                                          storedData;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade900,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple.shade800,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Navigator.pushNamed(context, 'DetailPage');
        },
        label: const Text(
          'Add Task',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add_box),
      ),
    );
  }
}
