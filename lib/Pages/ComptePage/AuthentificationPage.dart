import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/ComptePage/CreerComptePage.dart';
import 'package:fungola_app/Pages/ComptePage/MotDePasseOublie.dart';
import 'package:fungola_app/Pages/Page/MapsPage.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:fungola_app/widgets/Chargement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  late String _email, _password;
  @override
  bool isVisible = false;
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf5f3f8),
      body: Stack(
        children: [_body(context), Chargement(isVisible)],
      ),
    );
  }
  Widget _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Column(
              children: [
                _titre_widget(),
                _ChampWidget(),
                SizedBox(
                  height: 25,
                ),
                _button_widget(),
                SizedBox(
                  height: 20,
                ),
                _creerCompt_widget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _titre_widget() {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            child: Text("Fungola",
                style: TextStyle(
                  color: Utils.COLOR_BLUE,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Schyler",
                  fontSize: 29,
                ))),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Text(
                    "Pour pouvoir utiliser l'application, vous devez être connecté à vos identifiants.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget _ChampWidget() {
    return Column(
      children: [
        Container(
          width: 280,
          child: TextFormField(
            validator: (input) {
              if (input!.isEmpty) {
                return 'Entrez votre email*';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(input)) {
                return 'Entrez une adresse valide*';
              }return null;
            },
            onSaved: (input) => _email = input!,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Utils.COLOR_VIOLET,
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: Utils.COLOR_NOIR, fontSize: 12),

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
              contentPadding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 21),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 280,
          child: TextFormField(
            validator: (input) {
              if (input!.isEmpty) {
                return 'Entrez votre mot de passe*';
              }
              if (input!.length < 6) {
                return 'votre mot de passe doit comporter au moins 6 caractères';
              }return null;
            },
            onSaved: (input) => _password = input!,
            obscureText: isPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    isPassword = !isPassword;
                    setState(() {});
                  },
                  icon: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                    color: Utils.COLOR_VIOLET,
                  )),
              prefixIcon: Icon(
                Icons.lock,
                color: Utils.COLOR_VIOLET,
              ),
              labelText: "Mot de passe",
              labelStyle: TextStyle(color: Utils.COLOR_NOIR, fontSize: 12),
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 21),
            ),

          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Text(
                  "Mot de passe oublié?",
                  style: TextStyle(
                      color: Utils.COLOR_NOIR,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotDePasseOublie()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _button_widget() {
    return Container(
      width: 210,
      height: 45,
      child: ElevatedButton(
        onPressed: connexion,
        child: Text(
          "Se connecter",
          style: TextStyle(
              color: Utils.COLOR_BLANC,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schyler',
              fontSize: 19),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Utils.COLOR_VIOLET,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
  Widget _creerCompt_widget() {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("vous n'avez pas de compte"),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    child: GestureDetector(
                      child: Text(
                        "Créer mon compte",
                        style: TextStyle(
                            color: Utils.COLOR_NOIR,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreerComptePage()),
                        );
                      },
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
  void connexion() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!_formKey.currentState!.validate()) {
      return;
    }
    isVisible=true;
    setState(() {});
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


      _formKey.currentState!.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MapsPage()),
        );
      } on FirebaseAuthException catch (e) {

        String errorMessage = 'Une erreur s\'est produite.';
        if (e.code == 'user-not-found') {

          errorMessage = 'Aucun utilisateur trouvé pour cet e-mail.';
        } else if (

        e.code == 'wrong-password') {
          errorMessage = 'Mot de passe incorrect.';
        }
        setState(() {
          _password = '';
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Column(
                children: [
                  Icon(Icons.error_outline,size: 55,color: Utils.COLOR_ROUGE,),
                  Text('Erreur de connexion',style: TextStyle(fontFamily: 'Schyler',fontWeight: FontWeight.bold,color: Utils.COLOR_VIOLET),),
                ],
              ),
              content: Text(errorMessage,style: TextStyle(fontFamily: 'Schyler'),),
              actions: <Widget>[
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

      }

    }

    isVisible = false;
    setState(() {});
  }
}
