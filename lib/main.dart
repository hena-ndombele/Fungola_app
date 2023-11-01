import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apps/MonApplication.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyCCuWvyvCJ4qZyCkpT-8XSYjHOXpnb4MQo',
    appId: '1:15730194303:web:54949ecf81a960bb7b8c4a',
    messagingSenderId: '15730194303',
    projectId: 'fongolacar',
    databaseURL: "https://fongolacar-default-rtdb.firebaseio.com",
  ),);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light,),

  );

  //affichage erreur
  ErrorWidget.builder=(FlutterErrorDetails error){
    return Scaffold(
      body:Center(
        child: Text("Erreur inattendue"),),);
  };
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MonApplication());
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}



