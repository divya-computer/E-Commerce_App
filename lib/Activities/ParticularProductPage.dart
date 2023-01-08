// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:ecommercegarment/Activities/CartPage.dart';
import 'package:ecommercegarment/Activities/WistListPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// List<WishlistAdd> addList = [];

class ParticularProduct extends StatefulWidget {
  String product = "";
  ParticularProduct({super.key, required this.product});

  @override
  State<ParticularProduct> createState() => _ParticularProductState();
}

class _ParticularProductState extends State<ParticularProduct> {
  int length = 0;
  String a = "Divya Shaparia";
  List<dynamic> storeData = [];
  bool isLoading = false;
  bool isav = false;
  TextEditingController productQuantity = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    productQuantity.text = '1';
    showProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
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
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      storeData[0]['product_name'],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      storeData[0]['product_image'],
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (isav == true) {
                            // TO REMOVE FROM WISTLIST
                            setState(() {
                              isav = false;
                              removefromWistList();
                              // addList.removeAt(0);
                            });
                          } else {
                            // TO ADD INTO WISTLIST
                            setState(() {
                              isav = true;
                              addtoWistList();
                              // addList.add(WishlistAdd(
                              //     pPhoto: storeData[0]['product_image'],
                              //     pName: storeData[0]['product_name'],
                              //     pCat: storeData[0]['sub_category_name'],
                              //     pPrice: storeData[0]['product_price']));
                            });
                          }
                        },
                        icon: isav == true
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 40,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                        child: Text(
                          'Number of Product : ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Quantity'),
                            keyboardType: TextInputType.number,
                            controller: productQuantity,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Product Category : ${storeData[0]['sub_category_name']}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Product Details : ${storeData[0]['product_details']}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Product Price : ${storeData[0]['product_price']}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        height: 46,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ADD TO CART',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    print('You Clicked on Add to cart');
                  });
                  addtoCart();
                },
              ),
            ),
            // Expanded(
            //   child: InkWell(
            //     child: Container(
            //       alignment: Alignment.center,
            //       color: Colors.red,
            //       child: Text(
            //         "BUY NOW",
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            //       ),
            //     ),
            //     onTap: () {
            //       setState(() {
            //         print('You click on Buy Now');
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  showProductDetails() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-view-product.php?product_id=${widget.product}');
    var response = await http.get(url);

    print('Response Status : ${response.statusCode}');
    print('Response Body : ${response.body}');

    var mymap = json.decode(response.body);

    setState(() {
      storeData = mymap['product_list'];
      isLoading = false;
    });
    setState(() {
      length = storeData.length;
    });
    print('Length : $length');
  }

  addtoCart() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-cart-insert.php');

    var requestBody = {
      'user_id': counter,
      'product_id': widget.product,
      'product_qty': productQuantity.text
    };

    var response = await http.post(url, body: requestBody);

    var mymap = json.decode(response.body);
    print('Response body : ${response.body}');
    print('Response Status : ${response.statusCode}');

    if (mymap['flag'] == '0') {
      Fluttertoast.showToast(
        msg: "${mymap['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
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

    print('Successfully Data Inserted');
  }

  addtoWistList() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-wishlist-add.php');

    var requestBody = {'user_id': counter, 'product_id': widget.product};

    var response = await http.post(url, body: requestBody);

    var mymap = json.decode(response.body);
    print('Response body : ${response.body}');
    print('Response Status : ${response.statusCode}');

    Fluttertoast.showToast(
      msg: "Product added to wistlist",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  removefromWistList() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);
  }
}

// class WishlistAdd {
//   String pPhoto;
//   String pName;
//   String pCat;
//   String pPrice;

//   WishlistAdd(
//       {required this.pPhoto,
//       required this.pName,
//       required this.pCat,
//       required this.pPrice});
// }
