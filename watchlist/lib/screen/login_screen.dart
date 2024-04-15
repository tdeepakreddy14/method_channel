import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _login();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  Future<void> _login() async {
  MethodChannel platform = const MethodChannel('login_channel');
    try {
      final success = await platform.invokeMethod('login');
      print(success);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
