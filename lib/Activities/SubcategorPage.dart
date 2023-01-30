// ignore_for_file: prefer_const_constructors

import 'package:ecommercegarment/Activities/ProductListPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class subcategoryPage extends StatefulWidget {
  String abc;
  subcategoryPage({super.key, required this.abc});

  @override
  State<subcategoryPage> createState() => _subcategoryPageState();
}

class _subcategoryPageState extends State<subcategoryPage> {
  int categoryId = 0;
  List<dynamic> storeData = [];
  var checkempty = false;
  var checknotempty = false;
  bool loadingsubcategory = false;

  @override
  void initState() {
    // TODO: implement initState
    // categoryId = widget.abc + 1;
    productinfo(widget.abc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Category Product'),
        backgroundColor: Colors.amber,
      ),
      body: loadingsubcategory == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Visibility(
                  visible: checkempty,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        'No Product Found here',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: checknotempty,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: storeData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              storeData[index]['sub_category_image'],
                              height: 50,
                              width: 50,
                            ),
                            title: Text(storeData[index]['sub_category_name']),
                            subtitle: Text(storeData[index]['category_name']),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          productindex: storeData[index]
                                              ['sub_category_id'])));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  productinfo(String catId) async {
    setState(() {
      loadingsubcategory = true;
    });
    var uri = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-subcategory-list.php?category_id=$catId');
    var response = await http.get(uri);

    print('Response Status : ${response.statusCode}');
    print('Response Body : ${response.body}');

    var mymap = json.decode(response.body);

    setState(() {
      if (mymap['flag'] == "1") {
        setState(() {
          checknotempty = true;
        });
        storeData = mymap['sub_category_list'];
      } else {
        setState(() {
          checkempty = true;
        });
        print('No Product');
      }
    });
    setState(() {
      loadingsubcategory = false;
    });
  }
}
