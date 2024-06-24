import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryapptesting/pages/profile.dart';
import 'package:deliveryapptesting/pages/update_profile.dart';
import 'package:deliveryapptesting/pages/sign_in.dart';

class AppDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SETTINGS'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<DocumentSnapshot>(
              future: _fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  var userData = snapshot.data!;
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        // Example content; replace with user's profile image or initials
                        child: Icon(Icons.account_circle, size: 30, color: Colors.green),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData['firstName']} ${userData['lastName']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${userData['email']}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Text('Error');
                }
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text('Profile Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Update Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }

  Future<DocumentSnapshot> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();
      return userData;
    }
    throw 'User not found';
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
