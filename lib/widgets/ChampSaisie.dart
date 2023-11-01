import'package:flutter/material.dart';

class ChampSaisie extends StatefulWidget {
  String label="";
  String hintxt="";

  ChampSaisie({
   this.label="",
   this.hintxt=""
});

  @override
  State<ChampSaisie> createState() => _ChampSaisieState();
}

class _ChampSaisieState extends State<ChampSaisie> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hintxt
      ),

    );
  }
}
