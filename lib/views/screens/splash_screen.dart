import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  doChange(){
    Future.delayed(Duration(seconds: 3),() {
      Navigator.pushNamed(context, "HomePage");
    },);
  }
  @override
  void initState() {
    doChange();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.alarm,
          size: 300,
          color: Colors.purple,
        ),
      ),
    );
  }
}
