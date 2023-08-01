import 'package:flutter/material.dart';
import 'package:fungola_app/utils/ColorPage.dart';
import 'package:fungola_app/widgets/Chargement.dart';


class AjouterVehiculePage extends StatefulWidget {
  const AjouterVehiculePage({super.key});

  @override
  State<AjouterVehiculePage> createState() => _AjouterVehiculePageState();
}

class _AjouterVehiculePageState extends State<AjouterVehiculePage> {

  bool isVisible =false;
  final _formKey = GlobalKey<FormState>();
  List<String> _statusOptions = ['Peugeot', 'Renault', 'Mercedes','Opel','Audi','BMW'];
  List<String> _statusOptionss = ['Bleu', 'Marron', 'Jaune','Rouge','Blanche','Noir','Autres'];
  final _statusController = TextEditingController();
  final _statusControllers = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un véhicule"),
        backgroundColor: Utils.COLOR_VIOLET,
      ),
      body: Stack(
        children: [_body(context), Chargement(isVisible)],
      ),
    );
  }

  Widget _body(BuildContext context){
    return SingleChildScrollView(
        child: Center(
          child: Column(

            children: [
              Container(
                margin: EdgeInsets.only(top:50),
                child: Text("Information du véhicule",style: TextStyle(fontFamily: 'Schyler',fontSize: 25),),
              ),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: 280,
                        child: DropdownButtonFormField<String>(
                          items: _statusOptions.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          value: _statusController.text.isNotEmpty
                              ? _statusController.text
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _statusController.text = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner un statut';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.car_crash_outlined,
                              color: Utils.COLOR_VIOLET,
                            ),
                            labelText: "Marque du véhicule",
                            labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12,fontFamily:' Schyler'),

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
                      SizedBox(height: 25,),
                      Container(
                        width: 280,
                        child: TextFormField(

                          keyboardType: TextInputType.text,
                          obscureText: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "votre numéro d'immatriculation*";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.numbers,
                              color: Utils.COLOR_VIOLET,
                            ),
                            labelText: "Numéro d'immatriculation",
                            labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12,fontFamily:' Schyler'),

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
                      SizedBox(height: 25,),
                      Container(
                        width: 280,
                        child: DropdownButtonFormField<String>(
                          items: _statusOptionss.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          value: _statusControllers.text.isNotEmpty
                              ? _statusControllers.text
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _statusControllers.text = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Votre couleur';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.color_lens_outlined,
                              color: Utils.COLOR_VIOLET,
                            ),
                            labelText: "Couleur",
                            labelStyle: TextStyle(color: Utils.COLOR_NOIR,fontSize: 12,fontFamily:' Schyler'),

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
                  SizedBox(height: 70,),
                  Container(
                    width: 260,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: Utils.COLOR_BLANC,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Schyler',
                            fontSize: 21),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Utils.COLOR_VIOLET,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),)

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}
