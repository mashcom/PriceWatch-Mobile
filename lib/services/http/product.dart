import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductHttpService {
  final API_BASE = "http://10.150.0.176/price_watch/public/api";
  /**
   * Get list of products from API
   */
  Future getProducts() async {
    String url = "$API_BASE/product/";
    print(url);
    var response = await http.get(url);
    print("Response");
    print(response.body);
    return response.body;
  }

  Future getSingleProduct(String barCode) async {
    String url = "$API_BASE/product/" + barCode;
    var response = await http.get(url);
    print("Response");
    print(response.body);
    return response.body;
  }

  Future updatePrice(String barCode, double price) async {
    return null;
  }
}
