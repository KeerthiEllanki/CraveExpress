import 'package:flutter/material.dart';
import 'package:deliveryapptesting/model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyA0h6ea39GMz_jaqVfCfV2BkhRUJMYt4Dg',
      appId: '1:27276041104:web:58da1f983fb28ec2a4f115',
      messagingSenderId: '27276041104',
      projectId: 'testingapp-77a3c',
      authDomain: 'testingapp-77a3c.firebaseapp.com',
      storageBucket: 'testingapp-77a3c.appspot.com',
      measurementId: 'G-834Z0VV5RP',
      //appId: "YOUR_APP_ID",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}
