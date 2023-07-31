import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


void main() async {
  // Initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCCuWvyvCJ4qZyCkpT-8XSYjHOXpnb4MQo',
      appId: '1:15730194303:web:54949ecf81a960bb7b8c4a',
      messagingSenderId: '15730194303',
      projectId: 'fongolacar',
      databaseURL: "https://fongolacar-default-rtdb.firebaseio.com",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Realtime Database',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Déclare une variable pour stocker les données Firebase
  String _data = '';

  @override
  void initState() {
    super.initState();

    // Récupère la référence de la base de données
    final id_kit = "kit1";
    final databaseRef = FirebaseDatabase.instance.ref('kits/$id_kit');

    // Ecoute les changements de la base de données
    databaseRef.onValue.listen((event) {
      // Met à jour les données
      setState(() {
        _data = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Realtime Database Demo'),
      ),
      body: Center(
        child: Text('Données mises à jour : $_data'),
      ),
    );
  }
}