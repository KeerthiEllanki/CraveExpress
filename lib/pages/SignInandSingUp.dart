import 'package:flutter/material.dart';
import 'package:deliveryapptesting/pages/sign_in.dart';
import 'package:deliveryapptesting/pages/sign_up.dart';

class SignInSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set app bar color to green
        title: Text('CRAVE EXPRESS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button background color to green
              ),
              child: Text('Sign Up'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button background color to green
              ),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
