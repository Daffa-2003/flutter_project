import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/methods/api.dart';
import 'package:flutter_project/pages/Dashboard__page.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddData();
}

class _AddData extends State<AddData> {
  TextEditingController nameProduct = TextEditingController();
  TextEditingController hargaProduct = TextEditingController();
  TextEditingController quantityProduct = TextEditingController();
  String selectedType = 'Celana';
  String selectedKatagori = 'Pria';

  void addProduct() async {
    final data = {
      'name': nameProduct.text,
      'type': selectedType,
      'kategori': selectedKatagori,
      'harga': int.parse(hargaProduct.text),
      'quantity': int.parse(quantityProduct.text),
    };

    final result = await API().postRequest(route: "/addData", data: data);

    if (!mounted) return; // Pastikan widget masih mounted

    final response = jsonDecode(result.body);

    if (response['status'] == 200) {
      // Navigasi ke halaman Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tambah Product',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameProduct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Product',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: selectedType,
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue as String;
                });
              },
              items: <String>['Celana', 'Baju', 'Aksesoris']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type Product',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: selectedKatagori,
              onChanged: (newValue) {
                setState(() {
                  selectedKatagori = newValue.toString();
                });
              },
              items: <String>['Pria', 'Wanita', 'Anak']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Katego Product',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: hargaProduct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Harga Product',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: quantityProduct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantity Product',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                addProduct();
              },
              child: const Text('Tambah Product'),
            ),
          ),
        ],
      ),
    );
  }
}
