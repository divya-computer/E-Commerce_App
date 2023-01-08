// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:convert';
import 'package:ecommercegarment/Activities/ParticularOrderedHistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({super.key});

  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  List<dynamic> storeDate = [];
  bool anyOrder = true;

  @override
  void initState() {
    // TODO: implement initState
    loadOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        backgroundColor: Colors.amber,
      ),
      body: anyOrder == true
          ? Center(
              child: Text(
                "You dont have any Order's yet",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
            )
          : ListView.builder(
              itemCount: storeDate.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    child: ListTile(
                      leading: Icon(Icons.shopify),
                      title: Text(
                        'Order Id : ${storeDate[index]['order_id']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Amount : ${storeDate[index]['total_amount']}/-  \nDate : ${storeDate[index]['order_date']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              'Order Status : ${storeDate[index]['order_status']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      print(
                          'You clicked on Product : ${storeDate[index]['order_id']}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => orderedhistoryPage(
                                  orderId: storeDate[index]['order_id'])));
                    },
                  ),
                );
              },
            ),
    );
  }

  loadOrders() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-list.php');
    var response = await http.post(url, body: {'user_id': counter});

    var mymap = json.decode(response.body);

    if (mymap['flag'] == "0") {
      setState(() {
        anyOrder = true;
      });
    } else {
      setState(() {
        anyOrder = false;
      });
    }

    setState(() {
      storeDate = mymap['order_list'];
      print(storeDate);
    });
  }
}
