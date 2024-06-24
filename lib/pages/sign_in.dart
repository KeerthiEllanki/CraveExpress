import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deliveryapptesting/pages/restaurant_page.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _signInMessage = '';

  void _signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If sign-in successful, navigate to the next screen
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RestPage()),
        );
      }
    } catch (e) {
      print('Error during sign in: $e');
      // Handle sign-in failure, you can show an error message here
      setState(() {
        _signInMessage = 'Sign in failed';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_signInMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.green, // Set app bar color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green), // Text color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Border color
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green), // Text color
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Border color
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signIn(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button background color to green
              ),
              child: Text('Sign In', style: TextStyle(color: Colors.white)), // Set text color to white
            ),
          ],
        ),
      ),
    );
  }
}
