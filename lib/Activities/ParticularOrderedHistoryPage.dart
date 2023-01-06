// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class orderedhistoryPage extends StatefulWidget {
  String orderId = "";
  orderedhistoryPage({super.key, required this.orderId});

  @override
  State<orderedhistoryPage> createState() => _orderedhistoryPageState();
}

class _orderedhistoryPageState extends State<orderedhistoryPage> {
  bool isload = false;
  List<dynamic> storeData = [];
  TextEditingController cancelReason = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Id : ${widget.orderId}'),
        backgroundColor: Colors.amber,
      ),
      body: isload == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: storeData.length - 1,
              itemBuilder: (context, index) {
                int newindex = index + 1;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Image.network(
                        storeData[newindex]['product_image'],
                        height: 100,
                        width: 70,
                      ),
                      title: Text(
                        storeData[newindex]['product_name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Price : ${storeData[newindex]['product_price']} \n Product Quantity : ${storeData[newindex]['product_qty']}',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "Cancel Order",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onTap: () {
                  cancelorder();
                  setState(() {
                    print('Cancel Order : ');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadData() async {
    setState(() {
      isload = true;
    });

    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-list.php');
    var response = await http
        .post(url, body: {'user_id': counter, 'order_id': widget.orderId});
    var mymap = json.decode(response.body);

    setState(() {
      storeData = mymap['order_list'][0]['order_details'];
      print('Data : $storeData');
      isload = false;
    });
  }

  cancelorder() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('CANCEL ORDER ?', style: TextStyle(color: Colors.red)),
          content: TextField(
            controller: cancelReason,
            decoration: InputDecoration(
              hintText: "Let us know the reason",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                print('Cancel Pressed');
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                confirmcancel();
                print('Ok Pressed');
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  confirmcancel() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-remove.php');
    var response = await http.post(url, body: {
      'user_id': counter,
      'order_id': widget.orderId,
      'cancel_reason': cancelReason.text
    });
    var mymap = json.decode(response.body);

    print('Response Body : ${response.body}');
  }
}
