import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_fetch/controller.dart';



class LoginScreen extends StatelessWidget {
  final HomeController _loginController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: _loginController.updateUsername,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: _loginController.updatePassword,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await _loginController.loginUser();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
