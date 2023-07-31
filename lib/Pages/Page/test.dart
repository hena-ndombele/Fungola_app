import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/ComptePage/AuthentificationPage.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:fungola_app/widgets/Chargement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreerComptePage extends StatefulWidget {
  const CreerComptePage({Key? key}) : super(key: key);

  @override
  State<CreerComptePage> createState() => _CreerComptePageState();
}

class _CreerComptePageState extends State<CreerComptePage> {
  @override



  bool isVisible=false;
  bool isPassword1 = true;
  bool isPassword2 = true;
  var formKey = GlobalKey<FormState>();

  TextEditingController _nom=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _telephone=TextEditingController();
  TextEditingController _motdepasse=TextEditingController();
  TextEditingController _motdepassecomfirmer=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Stack(
        children: [_body(context), Chargement(isVisible)],

      ),
    );
  }
  Widget _body(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(

              child:  Container(
                  margin: EdgeInsets.only(top: 50,bottom: 20),
                  child: Column(
                      children: [
                        _titre_widget(),
                        _ChampWidget(),
                        SizedBox(height: 40,),
                        _button_widget(),
                        _text(),

                      ]  ))),
        )
    );
  }
  Widget _titre_widget(){
    return  Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
            "Créer mon compte",
            style: TextStyle(color: Utils.COLOR_BLUE,
              fontWeight: FontWeight.bold,
              fontFamily: "Schyler",fontSize: 25,)
        ));

  }
  Widget _ChampWidget(){

    return Column(
      children: [
        Container(
          width: 280,
          child: TextFormField(
            controller: _nom,
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
              labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12),

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
        SizedBox(height: 20,),
        Container(
          width: 280,
          child: TextFormField(
            controller: _email,
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
              labelText: 'Email',
              labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12),

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
        SizedBox(height: 20,),
        Container(
          width: 280,
          child: TextFormField(
            controller: _motdepasse,
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
                    isPassword1 ? Icons.visibility : Icons.visibility_off,
                    color: Utils.COLOR_VIOLET,
                  )),
              prefixIcon: Icon(
                Icons.lock,
                color: Utils.COLOR_VIOLET,
              ),
              labelText: 'Mot de passe',
              labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12),
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
        SizedBox(height: 20,),
        Container(
          width: 280,
          child: TextFormField(

            controller: _motdepassecomfirmer,
            keyboardType: TextInputType.text,
            obscureText: isPassword2,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "comfirmer votre mot de passe*";
              }
              if (value.length < 6) {
                return 'votre mot de passe doit comporter au moins 6 caractères';
              }

              return null;
            },
            decoration: InputDecoration(

              suffixIcon: IconButton(
                  onPressed: () {
                    isPassword2 = !isPassword2;
                    setState(() {});
                  },
                  icon: Icon(
                    isPassword2 ? Icons.visibility : Icons.visibility_off,
                    color: Utils.COLOR_VIOLET,
                  )),
              prefixIcon: Icon(
                Icons.lock,
                color: Utils.COLOR_VIOLET,
              ),
              labelText: 'Comfirmer mot de passe',
              labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12),
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
        SizedBox(height: 20),
        Container(
          width: 280,
          child: TextFormField(
            controller: _telephone,
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
              labelText: 'Téléphone',
              labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12),
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
      ],

    );
  }
  Widget _button_widget(){
    return   Container(
      width: 210,
      height: 45,
      child: ElevatedButton(
        onPressed: () async{
          FocusScope.of(context).requestFocus(new FocusNode());
          if (!formKey.currentState!.validate()) {
            return;
          }
          isVisible=true;
          setState(() {});
          FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _motdepassecomfirmer.text,).then((value) =>{
            print("compte créer avec success"),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthentificationPage()),
            )
          });

          isVisible = false;
          setState(() {});

          _nom.clear();
          _email.clear();
          _motdepassecomfirmer.clear();
          _motdepasse.clear();
          _telephone.clear();

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
  Widget _text(){
    return      Center(
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("En cliquant sur créer mon compte,",style: TextStyle(color: Utils.COLOR_GREY,fontFamily: 'Schyler'),),
            Text("vous accepter la condition d'utilisation de Fungola",style: TextStyle(color: Utils.COLOR_GREY,fontFamily: 'Schyler'))
          ],
        ),
      ),
    );
  }





}

