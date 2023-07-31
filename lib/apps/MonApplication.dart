import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/DemarragePage/SplashScreen.dart';




class MonApplication extends StatelessWidget {
  const MonApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
