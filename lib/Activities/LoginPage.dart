// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController uEmail = new TextEditingController();
  TextEditingController uPassword = new TextEditingController();
  String userId = "";
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login In Page'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration:
                  InputDecoration(labelText: 'Enter Your Email', filled: true),
              controller: uEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              obscureText: passwordVisible,
              controller: uPassword,
              decoration: InputDecoration(
                // border: UnderlineInputBorder(),
                labelText: "Enter your Password",
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              checklogin();
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          )
        ],
      ),
    );
  }

  Future<void> checklogin() async {
    var url = Uri.parse('https://akashsir.in/myapi/ecom1/api/api-login.php');
    final response = await http.post(url, body: {
      'user_email': uEmail.text,
      'user_password': uPassword.text,
    });

    print(response.body);
    var mapData = jsonDecode(response.body);

    var prefs = await SharedPreferences.getInstance();

    if (mapData['flag'] == "1") {
      print('You have Successfully Logged In');

      userId = mapData['user_id'];
      await prefs.setString('counter', userId);

      print('Your User Id = $userId');

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => homePage()));
    } else {
      print('Check your Details');

      return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('Check Your Details !!!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
