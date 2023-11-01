import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';
import 'package:fungola_app/Pages/Page/AproposPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fungola_app/utils/ColorPage.dart';



class ProfilPage extends StatefulWidget {


  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  XFile? imageSelectione;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:  _body(),
    );
  }

  Widget _body() {

    String userEmail = '';

    if (_auth.currentUser != null) {
      userEmail = _auth.currentUser!.email!;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 85,),
        InkWell(
          onTap: () async {},
          child: imageSelectione == null
              ? CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage(
              'images/Capture12.PNG',
            ),
          )
              : CircleAvatar(
            radius: 50.0,
            backgroundImage: FileImage(File(imageSelectione!.path)),
          ),


        ),
        SizedBox(height: 15,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Utils.COLOR_NOIR),
          child: TextButton(
            child: Text(
              'Changer ma photo',
              style: TextStyle(
                  color: Utils.COLOR_BLANC,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Schyler"),
            ),
            onPressed: () async {
              imageSelectione =
              await picker.pickImage(source: ImageSource.gallery);
              if (imageSelectione != null) {
                Directory directory = await getApplicationDocumentsDirectory();
                print(directory.path);
                var cheminSplit = imageSelectione!.path.split('/');
                String filename = cheminSplit.last;
                print(cheminSplit);
                print(filename);
                imageSelectione?.saveTo("${directory.path}/${filename}");
              }
              setState(() {});
            },
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
        SizedBox(height: 15),
        Expanded(
          child:
          ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Changer mon nom',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  leading: Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.black,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Changer le mot de passe',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  leading: Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'Apropos',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AproposPage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Se deconnecter',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 25,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                  onTap:(){
                    FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthentificationPage()))
                    });
                  },
                ),

              ]),
        ),
      ],
    );
  }

  ouvrirDialog(context) async {
    bool? resulat = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text("Déconnexion"),
          content: new Text("Voulez-vous vraiment vous déconnectez  ?"),
          actions: <Widget>[
            TextButton(
              child: new Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new TextButton(
              child: new Text(
                "Confirmer", style: TextStyle(color: Colors.orange),),
              onPressed: () {

              },
            ),
          ],
        );
      },
    );

    if (resulat != null) {
      var message = !resulat ? "Déconnexion annulée" : "Déconnexion";
      showSnackBar(context, message);
    }
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
      SnackBarAction(label: 'OK',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  Widget _noconnect(){
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/empty.gif"),
              SizedBox(height: 20.0),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Image.asset(
            "assets/app_icon2.png",
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
  }
}

getApplicationDocumentsDirectory() {
}