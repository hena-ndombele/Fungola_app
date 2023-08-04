import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/Page/AjouterVehiculePage.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:firebase_auth/firebase_auth.dart';




class ClePage extends StatefulWidget {
  @override
  _ClePageState createState() => _ClePageState();
}

class _ClePageState extends State<ClePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLocked = true;
 // final player = AudioCache();

  void _lockVehicle() {
    setState(() {
      _isLocked = true;
    });
    //player.play('audio/app_sound.mp3');
  }

  void _unlockVehicle() {
    setState(() {
      _isLocked = false;
    });

   // player.play('audio/app_sound.mp3');
  }

  @override
  Widget build(BuildContext context) {
  String userEmail = '';
  if (_auth.currentUser != null) {
  userEmail = _auth.currentUser!.email!;
  }
    return Scaffold(
      backgroundColor: Color(0XFFf5f3f8),
      body: Stack(
        children: [
          Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: 450,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/voiture.jpg"),
                  fit: BoxFit.fill,
                )),
            child: Container(
              padding: EdgeInsets.only(top: 60, left: 20),
              color: Utils.COLOR_NOIR.withOpacity(.90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(
                    children: [

                      RichText(
                        text: TextSpan(
                          text: "",
                          style: TextStyle(
                              color: Utils.COLOR_VIOLET,
                              fontWeight: FontWeight.bold,
                              fontSize: 49,
                              fontFamily: 'Schyler'),
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          text: "",
                          style: TextStyle(
                              color: Utils.COLOR_VIOLET,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Schyler',fontSize: 48),
                        ),
                      ),
                    ],

                  )
                ],
              ),
            ),
          )),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isLocked ? Icons.lock : Icons.lock_open,
                  size: 120.0,
                  color: Utils.COLOR_BLANC,
                ),
                SizedBox(height: 30.0),
                Text(
                  _isLocked ? 'Véhicule verrouillé' : 'Véhicule déverrouillé',
                  style: TextStyle(
                    fontSize: 29.0,
                    color: Utils.COLOR_BLANC,
                  ),
                ),
              ],
            ),
          ),
          Positioned(

              bottom: 200,
              child: Container(
                margin: EdgeInsets.all(25),
                width: 300,
                height: 70,
                child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AjouterVehiculePage()));
            },
            child: Text("Ajouter un véhicule",style: TextStyle(fontFamily: 'Schyler',fontSize: 19),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Utils.COLOR_GREEN
                  ),
          ),
              )),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  child: ElevatedButton(
                   // color: _isLocked ? Colors.grey : Colors.blue,
                    child: Text(
                      'Verrouiller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: _isLocked ? null : _lockVehicle,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Utils.COLOR_VIOLET
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: ElevatedButton(
                    // color: _isLocked ? Colors.blue : Colors.grey,
                    child: Text(
                      'Déverrouiller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: _isLocked ? _unlockVehicle : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Utils.COLOR_VIOLET
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}