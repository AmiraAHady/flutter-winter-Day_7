import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('ProductList Page'),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text('Go Home'),
        ),
      ),
    );
  }
}
