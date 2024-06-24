import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<UpdateProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? currentUser;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    _initializeControllers();
    _fetchUserData();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileController = TextEditingController();
    _emailController = TextEditingController();
  }

  void _fetchUserData() async {
    if (currentUser != null) {
      String userId = currentUser!.uid;

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        setState(() {
          _firstNameController.text = userDoc['firstName'];
          _lastNameController.text = userDoc['lastName'];
          _mobileController.text = userDoc['mobile'];
          _emailController.text = userDoc['email'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Setting'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextField(_firstNameController, 'First Name'),
            SizedBox(height: 12.0),
            buildTextField(_lastNameController, 'Last Name'),
            SizedBox(height: 12.0),
            buildTextField(_mobileController, 'Mobile Number',
                keyboardType: TextInputType.phone),
            SizedBox(height: 12.0),
            buildTextField(_emailController, 'Email',
                isEditable: false, fillColor: Colors.grey[200]),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (currentUser != null) {
                  String userId = currentUser!.uid;

                  await _firestore.collection('users').doc(userId).update({
                    'firstName': _firstNameController.text,
                    'lastName': _lastNameController.text,
                    'mobile': _mobileController.text,
                    'email': _emailController.text,
                    // Update more fields if needed
                  });

                  _fetchUserData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile updated successfully'),
                    ),
                  );
                }
              },
              child: const Text('Update Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text,
        bool isEditable = true,
        Color? fillColor}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: !isEditable,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
