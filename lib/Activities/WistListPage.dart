import 'package:ecommercegarment/Activities/ParticularProductPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WistList'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: addList.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: Image.network(
                //   addList[index].pPhoto,
                //   height: 100,
                //   width: 50,
                // ),
                key: ValueKey(index),
                title: Text(addList[index].pName),
                subtitle: Text(addList[index].pCat),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  highlightColor: Colors.red,
                  onPressed: () {
                    setState(() {});
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
