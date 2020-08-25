import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'single_product_page.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'models/product_model.dart';
import 'product.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  @override
  void initState() {
    super.initState();
    _scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.memory(bytes),
            ),
            Text('RESULT  $barcode'),
            RaisedButton(onPressed: _scan, child: Text("Scan")),
          ],
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    ProductsModel productModel = ProductsModel();
    print("BARCODE");
    print(barcode);
    productModel.getSingleProduct(barcode).then((response) {
      var product = jsonDecode(response);
      print(product["data"]);
      if (product["data"] != null) {
        print("result");
        var product_details = product["data"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: product_details,
              title: product_details["name"],
            ),
          ),
        );
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Product $barcode")));
        print("product not found");
      }
    });
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }

  Future _generateBarCode() async {
    Uint8List result = await scanner
        .generateBarCode('https://github.com/leyan95/qrcode_scanner');
    this.setState(() => this.bytes = result);
  }
}
