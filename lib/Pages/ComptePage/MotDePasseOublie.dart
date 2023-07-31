import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fungola_app/widgets/Chargement.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:connectivity/connectivity.dart';

class MotDePasseOublie extends StatefulWidget {
  @override
  _MotDePasseOublieState createState() => _MotDePasseOublieState();
}

class _MotDePasseOublieState extends State<MotDePasseOublie> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
@override
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_body(context), Chargement(isVisible)],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.only(top: 50, bottom: 20),
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Text("Mot de passe oublié?",
                    style: TextStyle(
                      color: Utils.COLOR_BLUE,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Schyler",
                      fontSize: 25,
                    ))),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Text(
                    "Entrez votre email ci-dessous",
                    style: TextStyle(fontSize: 17, fontFamily: 'Schyler'),
                  ),
                  Text("pour recevoir vos instructions de ",
                      style: TextStyle(fontSize: 17, fontFamily: 'Schyler')),
                  Text("réinitialisation du mot de passe.",
                      style: TextStyle(fontSize: 17, fontFamily: 'Schyler')),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.all(30),
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "votre adresse email*";
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Entrez une addresse valide*';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Utils.COLOR_VIOLET,
                    ),
                    labelText: 'Email',
                    labelStyle:
                    TextStyle(color: Utils.COLOR_NOIR, fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Utils.COLOR_VIOLET_CLAIRE,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Utils.COLOR_VIOLET,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Utils.COLOR_ROUGE,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Utils.COLOR_VIOLET,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(14, 21, 0, 21),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 230,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  isVisible=true;
                  setState(() {});

                  if (_formKey.currentState!.validate()) {
                    isVisible=true;
                    setState(() {});
                    String email = _emailController.text.trim();
                    _resetPassword(email);
                  }
                },
                child: Text("Réinitialiser le mot de passe"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Utils.COLOR_VIOLET,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  void _resetPassword(String email) async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (_formKey.currentState!.validate()) {
      if (connectivityResult == ConnectivityResult.none) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Column(
                children: [
                  Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_outlined,color: Utils.COLOR_VIOLET,size: 55,),
                  Text('Pas de connexion internet?',style: TextStyle(color: Utils.COLOR_VIOLET,fontWeight: FontWeight.bold,fontFamily: 'Schyler'),),
                ],
              ),
              content: Text('Veuillez vérifier votre connexion internet et réessayer.',style: TextStyle(fontFamily: 'Schyler'),),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Utils.COLOR_VIOLET,
                  ),
                ),
              ],
            );
          },

        );

        isVisible=false;
        return;
      }
      _auth.sendPasswordResetEmail(email: email).then((value) {
        // Afficher un message de succès à l'utilisateur
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("E-mail envoyé",style: TextStyle(color: Utils.COLOR_VIOLET,fontFamily: 'Schyler',fontWeight: FontWeight.bold),),
              content: Text(
                "Un e-mail de réinitialisation de mot de passe a été envoyé à votre adresse e-mail.",style: TextStyle(fontFamily: 'Schyler'),),
              actions: [
                TextButton(
                  child: Text("OK",style: TextStyle(color: Utils.COLOR_BLANC),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Utils.COLOR_VIOLET,
                  ),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Afficher un message d'erreur à l'utilisateur s'il y a une erreur
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur",style: TextStyle(color: Utils.COLOR_VIOLET,fontWeight: FontWeight.bold,fontFamily: 'Schyler'),),
              content: Text(
                "Une erreur s'est produite. Veuillez réessayer plus tard.",style: TextStyle(fontFamily: 'Schyler'),),
              actions: [
                TextButton(
                  child: Text("OK",style: TextStyle(color: Utils.COLOR_BLANC),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Utils.COLOR_VIOLET,
                  ),
                ),
              ],
            );
          },
        );
      });
    }

    // Envoyer un e-mail de réinitialisation du mot de passe à l'utilisateur

    isVisible=false;
    setState(() {});
  }

}
