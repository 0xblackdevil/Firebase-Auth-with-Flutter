import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/authService.dart';
import 'package:flutter_firebase/service/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User logged in "),
            Text("verified Status : ${UserData().emailVerified}"),
            MaterialButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                print(user);
              },
              child: Text("Get User Info"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          AuthService().signoutUser();
        },
        label: Text("Sign Out"),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
