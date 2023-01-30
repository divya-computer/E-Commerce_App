// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Old Passord',
                  ),
                  controller: oldPass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid number';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter New Passord',
                  ),
                  controller: newPass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid number';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm New Passord',
                  ),
                  controller: confirmPass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid number';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: ElevatedButton(
                    child: Text('Change Password'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      changePass();
                    },
                  ),
                ),
              ),
            ],
          ),
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

    if (newPass.text == confirmPass.text) {
      var response = await http.post(uri, body: requestBody);
      var map = json.decode(response.body);

      print('Data Updated Successfully');
      print('Response Status : ${response.statusCode}');
      print('Response body : ${response.body}');

      Fluttertoast.showToast(
        msg: "${map['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error : Password are not same",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
