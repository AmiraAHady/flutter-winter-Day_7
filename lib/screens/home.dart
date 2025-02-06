// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('settings');
                },
                child: Text('Go to Settings'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('categories');
                },
                child: Text('Go to Categories'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('products');
                },
                child: Text('Go to ProductList'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('movies');
                },
                child: Text('Go to Movies'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
