import 'package:flutter/material.dart';
import 'product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class PdPage extends StatefulWidget {
  final DocumentSnapshot product;
  final String title;

  PdPage({Key key, this.title, @required this.product}) : super(key: key);

  @override
  _PdPageState createState() => _PdPageState();
}

class _PdPageState extends State<PdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            primary: false,
            floating: true,
            flexibleSpace: productHero(),
            expandedHeight: 300,
            pinned: true,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => tileDetails(context, index),
              // Builds 1000 ListTiles
              childCount: 1000,
            ),
          ),
        ],
      ), /*Container(
        child: Column(
          children: <Widget>[
            productHero(),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.remove_red_eye,
                                color: Color.fromRGBO(0, 0, 0, 0.9),
                              ),
                              Text(
                                "Watched Supermarkets",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 0, 0, 0.9)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
            Expanded(child: productWatches(context))
          ],
        ),
      ),*/
    );
  }

  Widget productHero() {
    String product_image = widget.product.data['image'];
    String product_bar_code = widget.product.data['bar_code'];
    String product_price = widget.product.data['price'];
    print(product_image);
    return Stack(
      children: <Widget>[
        Hero(
          tag: product_bar_code,
          child: Center(
              /*child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 500),
              height: 300,
              placeholder: (context, url) => SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              imageUrl: product_image,
            ),*/
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
          left: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
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

  Widget productWatches(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(itemBuilder: tileDetails, itemCount: 10));
  }

  Widget tileDetails(BuildContext context, int index) {
    return ListTile(
      leading: FlutterLogo(size: 56.0),
      title: Text(
        'PicknPay',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text('Last Watched: 12/07/2019'),
      trailing: Text(
        '\$10.20',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }
}
