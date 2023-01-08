import 'dart:convert';

import 'package:ecommercegarment/Activities/ParticularProductPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<dynamic> storeDate = [];

  @override
  void initState() {
    // TODO: implement initState
    loadwistlistProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WistList'),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: storeDate.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                storeDate[index]['product_image'],
                width: 50,
                height: 100,
              ),
              title: Text(
                storeDate[index]['product_name'],
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Price : ${storeDate[index]['product_price']}'),
              trailing: InkWell(
                child: Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                  size: 35,
                ),
                onTap: () {
                  print('Clicked on Wistlist');
                  removeWistlist(storeDate[index]['wishlist_id']);
                },
              ),
            ),
          );
        },
      ),
      // Column(
      //   children: [
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: addList.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           // leading: Image.network(
      //           //   addList[index].pPhoto,
      //           //   height: 100,
      //           //   width: 50,
      //           // ),
      //           key: ValueKey(index),
      //           title: Text(addList[index].pName),
      //           subtitle: Text(addList[index].pCat),
      //           trailing: IconButton(
      //             icon: Icon(Icons.remove_circle),
      //             highlightColor: Colors.red,
      //             onPressed: () {
      //               setState(() {});
      //             },
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  loadwistlistProducts() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    counter = prefs.getString('counter').toString();
    print(counter);

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-wishlist-view.php');

    var response = await http.post(url, body: {'user_id': counter});

    var mymap = json.decode(response.body);

    setState(() {
      storeDate = mymap['wishlist'];
    });

    print('Response body : ${response.body}');
    print('Response Status : ${response.statusCode}');
  }

  removeWistlist(String wistlistid) async {
    var url = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-wishlist-remove.php');

    var response = await http.post(url, body: {'wishlist_id': wistlistid});

    print("Response Status : ${response.statusCode}");
    print("Response Body : ${response.body}");

    Fluttertoast.showToast(
      msg: "Product removed from wistlist",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
