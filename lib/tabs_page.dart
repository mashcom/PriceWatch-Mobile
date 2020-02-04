import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'scanner_page.dart';
import 'budget.dart';
import 'product_watchlist.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Watch',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "AirbnbCereal",
        platform: TargetPlatform.iOS,
        primaryTextTheme:
            TextTheme(headline: TextStyle(fontWeight: FontWeight.w700)),
        accentColor: Colors.indigoAccent,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(

              tabs: [
                Tab(
                  icon: Icon(Icons.fastfood),
                  text: "Products",
                ),
                Tab(
                  icon: Icon(Icons.remove_red_eye),
                  text: "Watching",
                ),
                Tab(
                  icon: Icon(Icons.camera_enhance),
                  text: "Scan",
                ),
              ],
            ),
            title: Text('PriceWatch'),

          ),
          body: TabBarView(
            children: [
              MyHomePage(),
              ProductWatchListPage(),
              ScannerPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => ScannerPage()));
            },
            child: Icon(Icons.camera_enhance),
          ),
        ),
      ),
    );
  }
}
