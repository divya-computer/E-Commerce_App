// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController oldPass = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Old Passord',
                ),
                controller: oldPass,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter New Passord',
                ),
                controller: newPass,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Passord',
                ),
                controller: confirmPass,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                child: ElevatedButton(
                  child: Text('Change Password'),
                  onPressed: () {
                    changePass();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePass() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();

    var uri = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-change-password.php');
    var requestBody = {
      'user_id': counter,
      'opass': oldPass.text,
      'npass': newPass.text,
      'cpass': confirmPass.text
    };

    var response = await http.post(uri, body: requestBody);

    print('Data Updated Successfully');
    print('Response Status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }
}
