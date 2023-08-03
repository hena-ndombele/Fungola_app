import 'package:flutter/material.dart';
import 'package:fungola_app/utils/ColorPage.dart';


class AproposPage extends StatefulWidget {
  const AproposPage({super.key});

  @override
  State<AproposPage> createState() => _AproposPageState();
}

class _AproposPageState extends State<AproposPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [
          Text("A propos"),

          Text("version actuelle : 1.0.0+1",style: TextStyle(color: Utils.COLOR_GREY),)
        ],
      ),

    );
  }
}
