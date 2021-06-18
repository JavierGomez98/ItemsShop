import 'package:flutter/material.dart';
import 'items_store_app/main_shoes_store_app.dart';

void main() {
  runApp(MainItemsStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Items Store',
      theme: ThemeData.dark(),
      home: MainItemsStore(),
    );
  }
}