import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class BudgetPage extends StatefulWidget {
  BudgetPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: customInputDecoration(
                      "Title", "", Icon(Icons.shopping_basket)),
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title of budget';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      customInputDecoration("Date", "", Icon(Icons.date_range)),
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter dates for budget';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: customBottomNav(context),
    );
  }

  customInputDecoration(String label, String hint, Icon inputIcon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: inputIcon,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
