// ignore_for_file: prefer_const_constructors

import 'package:ecommercegarment/Activities/BuyNowPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  List<dynamic> storeData = [];
  String totalPrice = "", totalQuantity = "";
  bool checkproduct = false;
  bool showmsgnoproduct = true;
  bool loadingproduct = false;

  @override
  void initState() {
    // TODO: implement initState
    loadProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        backgroundColor: Colors.amber,
      ),
      body: loadingproduct == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Visibility(
              visible: true,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: storeData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            storeData[index]['product_image'],
                            width: 50,
                            height: 100,
                          ),
                          title: Text(storeData[index]['product_name']),
                          subtitle: Text(storeData[index]['product_details']),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              print('Cart ID : ${storeData[index]['cart_id']}');
                              removeproductfromCart(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Visibility(
        visible: checkproduct,
        child: Container(
          height: 70,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        'Quantity : ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        totalQuantity,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 5),
                      child: Text(
                        'Total Price : ',
                        style: TextStyle(fontSize: 20),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        "$totalPrice/-",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "BUY NOW",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => buynowPage()));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadProduct() async {
    try {
      setState(() {
        loadingproduct = true;
      });
      String counter = "";
      var prefs = await SharedPreferences.getInstance();
      counter = prefs.getString('counter').toString();
      print(counter);

      var url =
          Uri.parse('https://akashsir.in/myapi/ecom1/api/api-cart-list.php');

      var requestBody = {'user_id': counter};
      var response = await http.post(url, body: requestBody);

      var mymap = json.decode(response.body);

      print("Response Status : ${response.statusCode}");
      print("\nResponse Body :  ${response.body}");

      setState(() {
        storeData = mymap['cart_list'];
        totalPrice = mymap['grand_total'];
        totalQuantity = mymap['total_qty'];
      });

      if (storeData.length != 0) {
        setState(() {
          showmsgnoproduct = false;
          checkproduct = true;
        });
      } else {
        setState(() {
          checkproduct = false;
          showmsgnoproduct = true;
        });
      }
      setState(() {
        loadingproduct = false;
      });
    } catch (error) {
      print('Something went Wrong');
      throw (error);
    }
  }

  removeproductfromCart(int index) async {
    var url = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-cart-remove-product.php');
    var response =
        await http.post(url, body: {'cart_id': storeData[index]['cart_id']});
    var mymap = json.decode(response.body);

    print("Response : ${response.body}");

    setState(() {
      storeData.removeAt(index);
    });

    Fluttertoast.showToast(
      msg: "${mymap['message']}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
