import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/methods/product.dart';
import 'package:flutter_project/pages/addData_page.dart';
import 'package:flutter_project/pages/updateDate_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project/methods/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  bool isLoading = false;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
    getProduct();
  }

  void getProduct() async {
    setState(() {
      isLoading = true;
    });
    final response = await OUT().postRequest(route: '/getData', data: {});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        List<Product> fetchedProducts = [];
        for (var item in responseData['data']) {
          fetchedProducts.add(Product.formJson(item));
        }
        if (!mounted) return;
        setState(() {
          products = fetchedProducts;
          isLoading = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        print('Error: ${responseData['message']}');
      }
    } else {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print('Error: ${response.body}');
    }
  }

  void getProductById(int id) async {
    final response = await OUT()
        .postRequest(route: '/getData/$id', data: {'id': id.toString()});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 200) {
        final product = Product.formJson(responseData['data']);
        if (!mounted) return;
      } else {
        print('Error: ${responseData['message']}');
      }
    } else {
      print('Error: ${response.body}');
    }
  }

  void deleteProduct(int id) async {
    final response = await DeleteData()
        .postRequest(route: '/deleteData/$id', data: {'id': id});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        getProduct();
      } else {
        print('Error: ${responseData['message']}');
      }
    } else {
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddData(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ),
              const Text(
                "Daftar Produk",
                style: TextStyle(
                  color: Color(0XFF475269),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'http://localhost/storage/product/${product.foto}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.kategori} ${product.type}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Stok: ${product.quantity}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp ${product.harga}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.brush_outlined),
                                  onPressed: () {
                                    getProductById(product.id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateData(product: product),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteProduct(product.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
