import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/authService.dart';

// ignore: must_be_immutable
class AuthScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to \nFlutter Firebase Doc",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text("Email"),
              TextField(
                controller: _emailController,
              ),
              SizedBox(height: 10),
              Text("password"),
              TextField(
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        var res = AuthService().signInWithEmail(
                            email: _emailController.text,
                            password: _passwordController.text);

                        if (res.toString() != "Failed") {
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      color: Colors.black,
                      height: 50,
                      onPressed: () {
                        var res = AuthService().signUpWithEmail(
                            email: _emailController.text,
                            password: _passwordController.text);
                        if (res.toString() != "Failed") {
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
