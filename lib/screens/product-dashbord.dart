// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:day_7/web_service/firebase_service.dart';
import 'package:flutter/material.dart';

class ProductDashbord extends StatefulWidget {
  const ProductDashbord({super.key});

  @override
  State<ProductDashbord> createState() => _ProductDashbordState();
}

class _ProductDashbordState extends State<ProductDashbord> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Map<String, dynamic> prodcuts = {};

  bool _isEditing = false;
  String? _editedProductId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsData();
  }

  void _saveData() async {
    final name = _nameController.text;
    final price = _priceController.text;
    var newProduct = {'name': name, 'price': int.parse(price)};
    if (_isEditing && _editedProductId != null) {
      //update product
      await _firebaseService.editProduct(_editedProductId!, newProduct);

      setState(() {
        _isEditing = false;
        _editedProductId = null;
      });
    } else {
      //add new Product
      await _firebaseService.addProduct(newProduct);
    }

    _nameController.clear();
    _priceController.clear();
    getProductsData();
  }

  void getProductsData() async {
    var response = await _firebaseService.getProducts();
    setState(() {
      prodcuts = response;
    });
  }

  void deleteProduct(String id) async {
    await _firebaseService.deleteProductData(id);
    getProductsData();
  }

  void _editProduct(String prodId, Map<String, dynamic> productData) {
    setState(() {
      _isEditing = true;
      _editedProductId = prodId;
      _nameController.text = productData['name'];
      _priceController.text = productData['price'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashbord'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: Text(_isEditing?'Edit product':'Add Product'),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: prodcuts.length,
                    itemBuilder: (context, index) {
                      final productId = prodcuts.keys.elementAt(index);
                      final productData = prodcuts[productId];
                      return ListTile(
                        title: Text('Name : ${productData['name']}'),
                        subtitle: Text(
                          'Price :\$ ${productData['price']}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _editProduct(productId, productData);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteProduct(productId);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
