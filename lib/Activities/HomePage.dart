// ignore_for_file: prefer_const_constructors, avoid_print, camel_case_types, use_rethrow_when_possible

import 'dart:convert';

import 'package:ecommercegarment/Activities/OrderHistoryPage.dart';
import 'package:ecommercegarment/Activities/SubcategorPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ProfilePage.dart';
import 'package:ecommercegarment/main.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController searchedText = new TextEditingController();
  List<dynamic> storeData = [];
  String cTd = "";

  @override
  void initState() {
    // ignore: todo
    viewdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => orderHistory()));
            },
            icon: Icon(Icons.shopping_bag),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilePage()));
            },
            icon: Icon(Icons.person),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                confirmlogout();
              },
              icon: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Search Product here',
                ),
                onChanged: (value) {
                  searchmethod(value);
                },
                controller: searchedText,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: storeData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      storeData[index]['category_image'],
                      height: 75,
                      width: 75,
                    ),
                    title: Text(storeData[index]['category_name']),
                    onTap: () {
                      print("You have Clicked on : $index");

                      setState(() {
                        cTd = storeData[index]['category_id'];
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => subcategoryPage(
                                    abc: cTd,
                                  )));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  viewdata() async {
    try {
      var url =
          Uri.http('akashsir.in', '/myapi/ecom1/api/api-view-category.php');
      var response = await http.get(url);

      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');

      var mymap = json.decode(response.body);
      setState(() {
        storeData = mymap['category_list'];
      });
    } catch (error) {
      print('Error in Api Calling');
      throw (error);
    }
  }

  searchmethod(String key) async {
    try {
      var url = Uri.parse(
          'https://akashsir.in/myapi/ecom1/api/api-search-product.php?product_name=$key');
      var response = await http.get(url);

      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');

      var mymap = json.decode(response.body);
      setState(() {
        storeData = mymap['product_list'];
      });
    } catch (error) {
      print('Error in Api Calling');
      throw (error);
    }
  }

  confirmlogout() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout ?',
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('NO'),
              onPressed: () {
                print('Cancel Pressed');
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('YES'),
              onPressed: () {
                print('Ok Pressed');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        );
      },
    );
  }
}
