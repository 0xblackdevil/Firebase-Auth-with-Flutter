import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/authScreen.dart';
import 'package:flutter_firebase/screen/homeScreen.dart';
import 'package:flutter_firebase/service/authService.dart';
import 'package:flutter_firebase/service/provider.dart';
import 'package:flutter_firebase/widget/firebaseWidget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootWidget(),
      ),
    );
  }
}

// ignore: must_be_immutable
class RootWidget extends StatelessWidget {
  Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInit,
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        if (snapshot.hasError) {
          return errorWidget();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthChecker();
        } else {
          return watingWidget();
        }
      },
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStatus,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasError) {
          return errorWidget();
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return AuthScreen();
          } else {
            return VerifactionChecker();
          }
        } else {
          return watingWidget();
        }
      },
    );
  }
}

class VerifactionChecker extends StatefulWidget {
  @override
  _VerifactionCheckerState createState() => _VerifactionCheckerState();
}

class _VerifactionCheckerState extends State<VerifactionChecker> {
  FirebaseAuth user = FirebaseAuth.instance;
  Timer timer;

  authCheckerFunction() {
    timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        user.currentUser.reload();
        if (user.currentUser.emailVerified) {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RootWidget(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user.currentUser.emailVerified) {
      return HomeScreen();
    } else {
      authCheckerFunction();
      return Scaffold(
        body: Center(
          child: Text("User Not Verified Email Id Yet"),
        ),
      );
    }
  }
}
