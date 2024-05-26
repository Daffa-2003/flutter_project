import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/methods/product.dart';

class UpdateData extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var product;

  UpdateData({super.key, required this.product});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController nameProduct = TextEditingController();
  TextEditingController hargaProduct = TextEditingController();
  TextEditingController quantityProduct = TextEditingController();
  String selectedType = 'Celana';
  String selectedKatagori = 'Pria';
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
              onPressed: () {},
              child: const Text('Tambah Product'),
            ),
          ),
        ],
      ),
    );
  }
}
