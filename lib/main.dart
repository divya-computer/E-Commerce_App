// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:ecommercegarment/Activities/HomePage.dart';
import 'package:ecommercegarment/Activities/LoginPage.dart';
import 'package:ecommercegarment/Activities/PrivacyPolicy.dart';
import 'package:ecommercegarment/Activities/TermsAndConditions.dart';
import 'package:flutter/material.dart';

import 'package:ecommercegarment/Activities/RegisterPage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Garment Ecommerce',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Shopping'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerPage()));
                        },
                        child: Text(
                          'Register In',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage()));
                      },
                      child: Text(
                        'Login In',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                    ),
                  ),
                  TextButton(
                    child: Text('skip login for now'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => homePage()));
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        onTap: () {
                          print('Clicked on terms & Conditions');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => termsAndConditions()));
                        },
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        print('Clicked on Privacy Policy');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => privacyPolicyPage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   child: Column(
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Center(
      //           child: ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => registerPage()));
      //             },
      //             child: Text(
      //               'Register In',
      //               style: TextStyle(
      //                 color: Colors.black,
      //               ),
      //             ),
      //             style:
      //                 ElevatedButton.styleFrom(backgroundColor: Colors.amber),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => loginPage()));
      //           },
      //           child: Text(
      //             'Login In',
      //             style: TextStyle(
      //               color: Colors.black,
      //             ),
      //           ),
      //           style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
      //         ),
      //       ),
      //       TextButton(
      //         child: Text('skip login for now'),
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => homePage()));
      //         },
      //       ),
      //       Align(
      //         alignment: Alignment.bottomLeft,
      //         child: Text('Helllo werol'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
