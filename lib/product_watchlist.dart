import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'product.dart';
import 'dart:convert';

class ProductWatchListPage extends StatefulWidget {
  ProductWatchListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProductWatchListPageState createState() => _ProductWatchListPageState();
}

class _ProductWatchListPageState extends State<ProductWatchListPage> {
  TextEditingController editingController = TextEditingController();
  bool _productListReady = false;

  ProductsModel product_model;
  List productList = List();

  @override
  void initState() {
    super.initState();
    populateProducts();
    print("getting started");
  }

  void populateProducts() {
    product_model = ProductsModel();
    product_model.getWatchList().then((resp) {
      productList = resp;

      setState(() {
        _productListReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (productList.length==0)
          ? Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.book,
                  size: 100,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Watchlist Empty"),

                SizedBox(
                  height: 30,
                ),
              ],
            ))
          : Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _productListReady
                        ? Column(
                            children: productList.map((item) {
                              String index = item["_id"].toString();
                              return Dismissible(
                                // Each Dismissible must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.
                                key: Key(index),
                                // Provide a function that tells the app
                                // what to do after an item has been swiped away.
                                onDismissed: (direction) {
                                  // Then show a snackbar.
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(item['name'] +
                                          " removed from watchlist")));
                                },
                                background: Container(color: Colors.deepOrange),
                                child: productWidget(context, item),
                              );
                            }).toList(),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
