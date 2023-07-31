import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';
import 'package:fungola_app/Pages/Page/MapsPage.dart';
import 'package:fungola_app/utils/ColorPage.dart';

class BienvenuePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String userEmail = '';

    if (_auth.currentUser != null) {
      userEmail = _auth.currentUser!.email!;
    }

    return Scaffold(
      backgroundColor: Color(0XFFf5f3f8),
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Utils.COLOR_VIOLET,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Utils.COLOR_VIOLET,
                  child: Icon(
                    Icons.person,
                    color: Utils.COLOR_BLANC,
                    size: 80,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text('$userEmail',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Utils.COLOR_GREY)),
                ),
              ],
            ),
            SizedBox(
              height: 150,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthentificationPage()))
                  });
                },
                child: Text("Se deconnecter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Utils.COLOR_VIOLET,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
