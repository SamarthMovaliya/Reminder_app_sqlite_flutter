import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/views/screens/detail_page.dart';
import 'package:reminder_app/views/screens/home_page.dart';
import 'package:reminder_app/views/screens/splash_screen.dart';
import 'package:reminder_app/views/screens/update_data.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'HomePage',
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          routes: {
            'HomePage': (context) => HomePage(),
            'SplashScreen': (context) => SplashScreen(),
            'DetailPage': (context) => DetailPAge(),
            'updatePage': (context) => UpdatePage(),
          },
        );
      },
    );
  }
}
