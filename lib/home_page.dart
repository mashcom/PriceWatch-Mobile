import 'package:flutter/material.dart';
import 'product.dart';
import 'dart:convert';
import 'scanner_page.dart';
import 'single_product_page.dart';
import 'models/product_model.dart';
import 'services/http/product.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  bool _productListReady = false;

  ProductHttpService product_model;
  List productList = List();

  @override
  void initState() {
    super.initState();
    populateProducts();
    print("getting started");
  }

  void populateProducts() {
    product_model = ProductHttpService();
    product_model.getProducts().then((resp) {
      var result = jsonDecode(resp);

      if (result['status']) {
        productList = result['data'];
      }

      setState(() {
        _productListReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 10),
              child: TextField(
                onChanged: (value) {},
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search Product",
                  hintText: "Search e.g Milk",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                            Text(
                              "Featured Products",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.6)),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            Expanded(
              child: _productListReady
                  ? SingleChildScrollView(
                      child: Column(
                        children: productList.map((item) {
                          return productWidget(context, item);
                        }).toList(),
                      ),
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
