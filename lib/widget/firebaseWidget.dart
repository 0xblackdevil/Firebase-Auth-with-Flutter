import 'package:flutter/material.dart';

Widget watingWidget() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget errorWidget() {
  return Scaffold(
    body: Center(
      child: Text("Error Occurs"),
    ),
  );
}

Widget statusWidget() {
  return Scaffold(
    body: Center(
      child: Text("Status Done"),
    ),
  );
}
