import 'package:flutter/material.dart';
import 'product.dart';
import 'custom/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';


class ProductDetailsPage extends StatefulWidget {
  final dynamic product;
  final String title;

  ProductDetailsPage({Key key, this.title, @required this.product})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  List watchList = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            primary: true,
            floating: true,
            flexibleSpace: productHero(),
            expandedHeight: 300,
            pinned: true,
            title:Text(widget.title),

          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
                  (context, index) {

                    return Column(
                      children: widget.product['history'].map<Widget>((item) {
                        return ListTile(
                          leading: CachedNetworkImage(
                            width:50,
                            fadeInDuration: Duration(milliseconds: 500),
                            //height: 300,
                            placeholder: (context, url) =>
                                SizedBox(
                                  child: CircularProgressIndicator(strokeWidth: 2,),
                                ),
                            imageUrl: item["organisation"]["logo"],
                          ),
                          title: Text(
                            item["organisation"]["name"],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(item["created_at"]),
                          trailing: Text(
                            item["price"].toString(),
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        );
                      }).toList(),
                    );
                  },
              // Builds 1000 ListTiles
              childCount: 1,
            ),
          ),
        ],
      ),

    );
  }

  Widget productHero() {
    String product_image = widget.product['image'];
    String product_bar_code = widget.product['bar_code'];
    String product_price = widget.product['price'].toString();
    print(product_image);
    return Stack(
      children: <Widget>[
        Hero(
          tag: product_bar_code,
          child: Center(
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 500),
              height: 300,
              placeholder: (context, url) =>
                  SizedBox(
                    child: CircularProgressIndicator(strokeWidth: 2,),
                  ),
              imageUrl: product_image,
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x0000000000), Color(0xd933333333)],
                  stops: [0.0, 0.9],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 0.5))),
        ),
        Positioned(
          height: 50,
          bottom: -1,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(0))),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



}
