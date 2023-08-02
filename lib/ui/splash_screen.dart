import 'package:flutter/material.dart';
import 'package:rajafsg/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splashservices splashScreen = splashservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(

        child: Text('Infobyte' , style: TextStyle(fontSize: 30),),
      ),
    );

  }
}
