import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/DemarragePage/IntroScreen.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 6),(){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder:(context) =>  IntroScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.COLOR_VIOLET,
      body:SizedBox(
        width: double.infinity,
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,


            children: [
              //SizedBox(height: 170,width: 270,child: Lottie.asset("images/67293-key-animation.json"),),
              Text("Fungola",style: TextStyle(color:Utils.COLOR_BLANC,fontWeight: FontWeight.bold,fontSize: 65,fontFamily: "Schyler"),),

            ],
          ),
        ),
      ),
    );
  }
}
