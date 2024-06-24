import 'package:flutter/material.dart';
import 'package:deliveryapptesting/pages/restaurant_page.dart';
import 'SignInandSingUp.dart';
import 'chikfila_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRAVE EXPRESS',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/intro.png"), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 30.0), // Add top padding of 30 pixels
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Center(
                child: Text(
                  'Express your Craving!! ',
                  style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 22.0), // Increase text size
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Get your food at your doorstep!!',
                  style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 22.0), // Increase text size
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInSignUp()));
                  },
                  child: Text(
                    'Get Started>>',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0), // Increase text size
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change button color to green
                    minimumSize: Size(200, 50), // Set the minimum button size
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
