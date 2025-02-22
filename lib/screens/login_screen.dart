import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login/Signup')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            child: Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement login/signup functionality
            },
            child: Text('Login/Signup'),
          ),
        ],
      ),
    );
  }
}
