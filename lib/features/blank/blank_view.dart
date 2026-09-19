import 'package:flutter/material.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to Blank View! You are logged in.'),
      ),
    );
  }
}