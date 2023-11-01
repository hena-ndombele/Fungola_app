import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';
import 'package:fungola_app/widgets/Chargement.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:connectivity/connectivity.dart';

class CreerComptePage extends StatefulWidget {
  @override
  _CreerComptePageState createState() => _CreerComptePageState();
}

class _CreerComptePageState extends State<CreerComptePage> {
  bool isVisible = false;
  bool isPassword1 = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _ref = FirebaseDatabase.instance.reference().child('users');
  String errorMessage = 'Une erreur s\'est produite.';

  void _registerUser() async {
    isVisible = true;
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
                  Icon(
                    Icons
                        .signal_wifi_statusbar_connected_no_internet_4_outlined,
                    color: Utils.COLOR_VIOLET,
                    size: 55,
                  ),
                  Text(
                    'Pas de connexion internet?',
                    style: TextStyle(
                        color: Utils.COLOR_VIOLET,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Schyler'),
                  ),
                ],
              ),
              content: Text(
                'Veuillez vérifier votre connexion internet et réessayer.',
                style: TextStyle(fontFamily: 'Schyler'),
              ),
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
      }

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Enregistrer les données utilisateur dans la base de données
        _ref.child(userCredential.user!.uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        });

        // Naviguer vers la page d'accueil après l'enregistrement
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AuthentificationPage()));
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Une erreur s\'est produite.';
        if (e.code == 'weak-password') {
          errorMessage = 'Le mot de passe est trop faible.';
          print('Le mot de passe est trop faible.');
        } else if (e.code == 'email-already-in-use') {
          errorMessage =
              'L\'adresse e-mail est déjà utilisée pour un autre compte.';
        } else {
          errorMessage = 'Erreur lors de la création du compte : ${e.message}';
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 55,
                    color: Utils.COLOR_ROUGE,
                  ),
                  Text(
                    'Erreur de connexion',
                    style: TextStyle(
                        fontFamily: 'Schyler',
                        fontWeight: FontWeight.bold,
                        color: Utils.COLOR_VIOLET),
                  ),
                ],
              ),
              content: Text(
                errorMessage,
                style: TextStyle(fontFamily: 'Schyler'),
              ),
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
      } catch (e) {
        print(e);
      }
    }

    isVisible = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_body(context), Chargement(isVisible)],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Column(children: [
                _titre_widget(),
                _ChampWidget(),
                SizedBox(
                  height: 40,
                ),
                _button_widget(),
                _text(),
              ]))),
    );
  }
  Widget _titre_widget() {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Text("Créer mon compte",
            style: TextStyle(
              color: Utils.COLOR_BLUE,
              fontWeight: FontWeight.bold,
              fontFamily: "Schyler",
              fontSize: 25,
            )));
  }
  Widget _ChampWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "votre nom*";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Utils.COLOR_VIOLET,
                        ),
                        labelText: "Nom",
                        labelStyle: TextStyle(
                            color: Utils.COLOR_NOIR,
                            fontSize: 12,
                            fontFamily: ' Schyler'),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "votre adresse email*";
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Entrez une addresse valide*';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Utils.COLOR_VIOLET,
                        ),
                        labelText: "Email",
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "votre numéro de téléphone*";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Utils.COLOR_VIOLET,
                        ),
                        labelText: "Téléhone",
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 280,
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isPassword1,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "votre mot de passe*";
                        }
                        if (value.length < 6) {
                          return 'votre mot de passe doit comporter au moins 6 caractères';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              isPassword1 = !isPassword1;
                              setState(() {});
                            },
                            icon: Icon(
                              isPassword1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Utils.COLOR_VIOLET,
                            )),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Utils.COLOR_VIOLET,
                        ),
                        labelText: 'Mot de passe',
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
                ],
              ),
            ),
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
        onPressed: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (!_formKey.currentState!.validate()) {
            return;
          }
          isVisible = true;
          setState(() {});
          _registerUser();
        },
        child: Text(
          "Créer mon compte",
          style: TextStyle(
              color: Utils.COLOR_BLANC,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schyler',
              fontSize: 17),
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
  Widget _text() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "En cliquant sur créer mon compte,",
              style: TextStyle(color: Utils.COLOR_GREY, fontFamily: 'Schyler'),
            ),
            Text("vous accepter la condition d'utilisation de Fungola",
                style:
                    TextStyle(color: Utils.COLOR_GREY, fontFamily: 'Schyler'))
          ],
        ),
      ),
    );
  }
}
