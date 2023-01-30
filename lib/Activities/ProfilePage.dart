// ignore_for_file: prefer_const_constructors

import 'package:ecommercegarment/Activities/ChangePassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  TextEditingController Uname = new TextEditingController();
  TextEditingController Uemail = new TextEditingController();
  TextEditingController Ugender = new TextEditingController();
  TextEditingController Uaddress = new TextEditingController();
  TextEditingController Umobile = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.amber,
      ),
      body:
          // FutureBuilder(
          //   future: null,
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (0 == 0) {
          //       return Column(
          //         // ignore: prefer_const_literals_to_create_immutables
          //         children: [Text('Hello '),
          //         Text('This is Divya shaparia here'),
          //         ],
          //       );
          //     } else {}
          //   },
          // ),
          SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Center(
              child: Icon(
                Icons.face_outlined,
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  filled: true,
                ),
                controller: Uname,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  filled: true,
                ),
                controller: Uemail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Gender',
                  filled: true,
                ),
                controller: Ugender,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Address',
                  filled: true,
                ),
                controller: Uaddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Mobile',
                  filled: true,
                ),
                controller: Umobile,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10.0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => changePassword()));
                    },
                    child: Text('Change Password'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateProfile();
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse("https://akashsir.in/myapi/ecom1/api/api-user-update.php");
    var requestBody = {
      'user_id': counter,
      'user_name': Uname.text,
      'user_email': Uemail.text,
      'user_gender': Ugender.text,
      'user_address': Uaddress.text,
      'user_mobile': Umobile.text
    };

    var response = await http.post(url, body: requestBody);

    print('Data Updated Successfully');
    print('Response Status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }
}
