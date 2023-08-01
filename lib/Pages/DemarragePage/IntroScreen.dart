import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:lottie/lottie.dart';




class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: IntroductionScreen(
          globalBackgroundColor:Utils.COLOR_BLANC,
          scrollPhysics: BouncingScrollPhysics(),
          pages: [
            PageViewModel(
                titleWidget: const Text(
                  "Votre emplacement",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color:Utils.COLOR_VIOLET,
                      fontFamily: 'Schyler'
                    // color: Color.fromRGBO(158, 79, 194, 0)
                  ),
                ),
                body:
                "Connectez-vous pour voir en temps réel la position de votre véhicule.",
              image:SizedBox(height: 170,width: 270,child: Lottie.asset("images/animation_lkqfdai8.json"),),),
            PageViewModel(
                titleWidget: const Text(
                  "Visualiser vos Trajets",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    fontFamily: 'Schyler',
                    color:Utils.COLOR_VIOLET,
                  ),
                ),
                body:
                "Parcourer la liste de vos derniers trajets après la course.",

          image:SizedBox(height: 170,width: 270,child: Lottie.asset("images/animation_lkpmp5t9.json"),),

            ),
            PageViewModel(
                titleWidget: const Text(
                  "Sécurisez votre véhicule",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color:Utils.COLOR_VIOLET,
                    fontFamily: 'Schyler',
                  ),
                ),
                body:
                "Utiliser l'application pour vérrouiller et déverrouiller votre véhicule à distance.",
              image:SizedBox(height: 170,width: 270,child: Lottie.asset("images/77323-profile-lock.json"),),),
          ],
          onDone: () {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder:(context) => AuthentificationPage()),
            );
          },
          next: const Icon(
            Icons.arrow_forward,
            color: Utils.COLOR_VIOLET
          ),
          done: Container(
            child: Text(
              "Se connecter",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Utils.COLOR_VIOLET,
                fontFamily: 'Schyler',
              ),
            ),
          ),
          dotsDecorator: DotsDecorator(
              size: Size.square(7.0),
              activeSize: Size(15.0, 10.0),
              color: Colors.black26,
              activeColor: Utils.COLOR_VIOLET,
              spacing: EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )),
        ),
      ),
    );
  }
}