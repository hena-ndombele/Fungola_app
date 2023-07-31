import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';


class DeconnexionPage extends StatefulWidget {
  const DeconnexionPage({super.key});

  @override
  State<DeconnexionPage> createState() => _DeconnexionPageState();
}

class _DeconnexionPageState extends State<DeconnexionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut().then((value) => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthentificationPage()))
              });
            }, child: Text("Deconnexion")),
      ),
    );
  }
}
