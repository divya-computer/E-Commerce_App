// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController uName = new TextEditingController();
  TextEditingController uEmail = new TextEditingController();
  TextEditingController uPassword = new TextEditingController();
  TextEditingController uGender = new TextEditingController();
  TextEditingController uMobile = new TextEditingController();
  TextEditingController uAddress = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Here"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter User Name'),
                  controller: uName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Something';
                    }
                    if (value.length < 5) {
                      return 'Field should minimum of 5 characters';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Email'),
                  controller: uEmail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a value mail';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Password'),
                  controller: uPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    if (value.length < 5) {
                      return 'Password should atleast 8 characters';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Gender'),
                  controller: uGender,
                  validator: (value) {
                    if (!(value == "male" ||
                        value == "Male" ||
                        value == "female" ||
                        value == "Female")) {
                      return 'Enter gender properly';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Mobile'),
                  controller: uMobile,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!(value!.length == 10)) {
                      return 'Please enter valid number';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Enter Address'),
                  controller: uAddress,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  registerdata();
                },
                child: Text('REGISTER'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
// user_name
// user_email
// user_password
// user_gender
// user_mobile
// user_address

  void registerdata() async {
    var url = Uri.parse('https://akashsir.in/myapi/ecom1/api/api-signup.php');

    var requestBody = {
      'user_name': uName.text,
      'user_email': uEmail.text,
      'user_password': uPassword.text,
      'user_gender': uGender.text,
      'user_mobile': uMobile.text,
      'user_address': uAddress.text
    };

    var response = await http.post(url, body: requestBody);

    print('Data Entered Successfully !!!');
    print('Response Status : ${response.statusCode}');
    print('Response Body : ${response.body}');
  }
}
