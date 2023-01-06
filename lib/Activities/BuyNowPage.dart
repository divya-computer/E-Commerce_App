// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, body_might_complete_normally_nullable, camel_case_types, unnecessary_new, use_rethrow_when_possible, unused_import

import 'dart:convert';
import 'dart:ffi';

import 'package:ecommercegarment/Activities/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class buynowPage extends StatefulWidget {
  const buynowPage({super.key});

  @override
  State<buynowPage> createState() => _buynowPageState();
}

class _buynowPageState extends State<buynowPage> {
  TextEditingController shippingName = new TextEditingController();
  TextEditingController shippingMobileNumber = new TextEditingController();
  TextEditingController shippingAddress = new TextEditingController();
  TextEditingController shippingPaymentMethod = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Now'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Shipping Name'),
                  controller: shippingName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field id required';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Shipping Mobile Number',
                  ),
                  keyboardType: TextInputType.number,
                  controller: shippingMobileNumber,
                  validator: (value) {
                    if (!(value!.length == 10)) {
                      return 'Enter a valid 10 digit number';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Shipping Address',
                  ),
                  maxLines: 3,
                  controller: shippingAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter payment method (CASH or CARD)'),
                  controller: shippingPaymentMethod,
                  validator: (value) {
                    if (!(value == "Cash" ||
                        value == "cash" ||
                        value == "Card" ||
                        value == "card")) {
                      return "Please enter valid option ";
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        color: Colors.orange,
        child: ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            confirmOrder();
          },
          child: Text(
            'CONFIRM ORDER !!!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  confirmOrder() async {
    try {
      String counter = "";
      var prefs = await SharedPreferences.getInstance();
      counter = prefs.getString('counter').toString();
      print(counter);

      var url =
          Uri.parse("https://akashsir.in/myapi/ecom1/api/api-add-order.php");
      var requestBody = {
        'user_id': counter,
        'shipping_name': shippingName.text,
        'shipping_mobile': shippingMobileNumber.text,
        'shipping_address': shippingAddress.text,
        'payment_method': shippingPaymentMethod.text
      };
      var response = await http.post(url, body: requestBody);
      var map = json.decode(response.body);

      print('Data Entered Successfully !!!');
      print('Response Status : ${response.statusCode}');
      print('Response Body : ${response.body}');

      if (map['flag'] == "1") {
        return showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: AlertDialog(
                title: Text('CONGRATULATIONS Order is placed !!!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => homePage())));
                    },
                    child: Text(
                      'Return to HomePage',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: AlertDialog(
                title: Text('There is some Error'),
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
    } catch (error) {
      print('There is some Issue While ordering');
      throw (error);
    }
  }
}
