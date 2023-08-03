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
appBar: AppBar(
  title: Text("A propos"),
  backgroundColor: Utils.COLOR_VIOLET,
),

      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 50,),
             Image.asset(
                'images/Capture12.PNG',width: 100,
              ),
              SizedBox(height: 10,),
              Text("version actuelle : 1.0.0",style: TextStyle(color: Utils.COLOR_GREY,fontSize: 17),)
            ],
          ),
        ),
      ),

    );
  }
}
