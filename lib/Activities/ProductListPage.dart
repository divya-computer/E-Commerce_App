// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:ecommercegarment/Activities/WistListPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ParticularProductPage.dart';
import 'CartPage.dart';

class ProductPage extends StatefulWidget {
  String productindex;
  ProductPage({super.key, required this.productindex});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int productIn = 0;
  List<dynamic> storeData = [];

  @override
  void initState() {
    // TODO: implement initState
    // productIn = widget.productindex + 1;
    productLoad(widget.productindex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List Page'),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => cartPage()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishListPage()));
              },
              icon: Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: storeData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                storeData[index]['product_image'],
                height: 100,
                width: 50,
              ),
              title: Text(storeData[index]['product_name']),
              onTap: () {
                print(storeData[index]['product_id']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParticularProduct(
                              product: storeData[index]['product_id'],
                            )));
              },
            ),
          );
        },
      ),
    );
  }

  productLoad(String pId) async {
    var url = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-view-product.php?sub_category_id=${pId}');
    // var url =
    //     Uri.parse('https://akashsir.in/myapi/ecom1/api/api-view-product.php');

    var response = await http.get(url);

    print('Response Status : ${response.statusCode}');
    print('Response Body : ${response.body}');

    var mymap = json.decode(response.body);

    // if (mymap['product_list']['sub_category_id'] == productIn) {
    //   setState(() {
    //     storeData = mymap['product_list'];
    //   });
    // }
    setState(() {
      if (mymap["flag"] == "1") {
        storeData = mymap['product_list'];
      } else {
        print("No Product in this category");
      }
    });
  }
}
