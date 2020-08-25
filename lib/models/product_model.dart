import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Product {
  int id;
  String bar_code;
  String name;
  String image;
  double price;
  String created_at;
  String updated_at;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "bar_code": bar_code,
      "name": name,
      "image": image,
      "price": price,
      "created_at": created_at,
      "updated_at": updated_at
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Product();

  Product.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    bar_code = map["bar_code"];
    name = map["name"];
    image = map["image"];
    price = map["price"];
    created_at = map["created_at"];
    updated_at = map["updated_at"];
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        bar_code = json["bar_code"],
        name = json["name"],
        image = json["image"],
        price = json["price"],
        created_at = json["created_at"],
        updated_at = json["updated_at"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "bar_code": bar_code,
        "name": name,
        "image": image,
        "price": price,
        "created_at": created_at,
        "updated_at": updated_at
      };
}

class ProductsModel {
  final String tableProducts = 'products';
  final String tableUserAuth = 'user_auth';
  final String columnId = '_id';
  final String columnBarCode = 'bar_code';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnImage = 'image';
  final String columnCreatedAt = 'created_at';
  final String columnUpdatedAt = 'updated_at';
  final String databaseName = 'pricewatch_zw_hubszw.db';

  Database db;

  Future<Database> get db_con async {
    if (db != null) return db;
    db = await open();
    return db;
  }

  Future<String> getDatabasePath(String databaseName) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    return path;
  }

  Future open() async {
    final path = await getDatabasePath(databaseName);
    db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
      await db.execute('''
  create table $tableProducts ( 
    $columnId integer primary key autoincrement,
     $columnName text not null,
     $columnPrice text not null,
    $columnBarCode text not null unique,
    $columnImage text not null,
     $columnCreatedAt text not null,
      $columnUpdatedAt text not null)
''');
    });
    print(db);
    return db;
  }

  /**
   * Get list of products from API
   */
  Future getProducts() async {
    String url = "http://192.168.43.195/price_watch/public/api/product/";
    var response = await http.get(url);
    print("Response");
    print(response.body);
    return response.body;
  }

  Future getSingleProduct(String barCode) async {
    String url =
        "http://192.168.43.195/price_watch/public/api/product/" + barCode;
    var response = await http.get(url);
    print("Response");
    print(response.body);
    return response.body;
  }

  Future getSingleProductFromDb(String barCode) async{
    var dbClient = await db_con;

    var product = await dbClient.rawQuery(
      'SELECT * FROM products WHERE $columnBarCode=$barCode'
    );
    print("check existence");
    print(product);
    return product;
  }

  Future addToWatchList(product) async {
    var dbClient = await db_con;

    int insert_id = await dbClient.rawInsert(
        'INSERT INTO $tableProducts($columnName,$columnBarCode,$columnImage,$columnPrice,$columnCreatedAt,$columnUpdatedAt) VALUES(?,?,?,?,?,?)',
        [
          product["name"],
          product["bar_code"],
          product["image"],
          product["price"],
          product["created_at"],
          product["updated_at"]
        ]);
    print('inserted1: $insert_id');
    return (insert_id != null);
  }

  Future getWatchList() async {
    var dbClient = await db_con;
    print("watch list");
    var result = await dbClient.rawQuery('SELECT * FROM $tableProducts');
    print(result);
    return result;
  }
}
