import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'single_product_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductModel {
  double id;
  String name;
  double price;
  String barCode;

  ProductModel({this.id, this.name, this.barCode, this.price});
}

TextStyle widgetStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

void _settingModalBottomSheet(context,product){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.remove_red_eye),
                  title: new Text('Watch Product'),
                  onTap:(){
                    ProductsModel product_model = ProductsModel();
                    product_model.addToWatchList(product).then((resp) {
                      if (resp == true) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(product["name"] + " successfully added to WatchList")));
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Error adding to watchlist")));
                      }
                    });
                  }
              ),
              new ListTile(
                leading: new Icon(Icons.update),
                title: new Text('Update Price'),
                onTap: () => {},
              ),
            ],
          ),
        );
      }
  );
}
Widget productWidget(BuildContext context, product) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(
            product: product,
            title: product["name"],
          ),
        ),
      );
    },
    leading: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                border:
                Border.all(color: Color.fromRGBO(0, 0, 0, 0.1), width: 0)),
            child: Hero(
              tag: product["bar_code"].toString(),
              child: CachedNetworkImage(

                placeholder: (context, url) => SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                imageUrl: product["image"],
              ),
            ),
          ),
        )
      ],
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${product["name"]}",
          style: TextStyle(
              color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Text(
              "\$${product["price"]}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ],
    ),
    subtitle: Row(
      children: <Widget>[
        storesWatched(Colors.red, "OK"),
        storesWatched(Colors.blueAccent, "PnP"),
        storesWatched(Colors.green, 'DCK'),
        storesWatched(Colors.black, '+3'),
      ],
    ),

    onLongPress: () {
      _settingModalBottomSheet(context,product);

    },

  );
}

Widget storesWatched(Color background, String storeName) {
  return SizedBox(
    height: 25,
    child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  storeName,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ))),
  );
}
