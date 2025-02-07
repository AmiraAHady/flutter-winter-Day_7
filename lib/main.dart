// ignore_for_file: prefer_const_constructors

import 'package:day_7/navigation/bottomNav.dart';
import 'package:day_7/navigation/tabBarNav.dart';
import 'package:day_7/screens/categories.dart';
import 'package:day_7/screens/home.dart';
import 'package:day_7/screens/movie_screen.dart';
import 'package:day_7/screens/product-dashbord.dart';
import 'package:day_7/screens/product_details.dart';
import 'package:day_7/screens/product_list.dart';
import 'package:day_7/screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: TabBarExample()
      // BottomNavigationBarDemo(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'settings': (context) => SettingPage(),
        'categories': (context) => CategoriesPage(),
        'products': (context) => ProductListPage(),
        'movies': (context) => MovieListPage(),
        'productDashbord': (context) => ProductDashbord(),

        // 'productDetails': (context) => ProductDetailsScreen(),
       
        
      },
    );
  }
}
