import 'package:flutter/material.dart';
import 'package:imacs/imacs_test.dart';

void main(List<String> args) {
  runApp(Imacs());
}

class Imacs extends StatelessWidget {
  const Imacs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImacsScreen(),
    );
  }
}