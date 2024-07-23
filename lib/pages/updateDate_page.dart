import 'package:flutter/material.dart';
import 'package:flutter_project/methods/product.dart';

class UpdateData extends StatefulWidget {
  final Product product;

  const UpdateData({required this.product, super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  late TextEditingController nameProduct;
  late TextEditingController hargaProduct;
  late TextEditingController quantityProduct;
  late String selectedType;
  late String selectedKatagori;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers and variables with the current product data
    nameProduct = TextEditingController(text: widget.product.name);
    hargaProduct = TextEditingController(text: widget.product.harga.toString());
    quantityProduct =
        TextEditingController(text: widget.product.quantity.toString());
    selectedType = widget.product.type;
    selectedKatagori = widget.product.kategori;
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    nameProduct.dispose();
    hargaProduct.dispose();
    quantityProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Update Product',
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: DropdownButtonFormField<String>(
          //     value: selectedType,
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedType = newValue!;
          //       });
          //     },
          //     items: <String>['Celana', 'Baju', 'Aksesoris']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //     decoration: const InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Type Product',
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: DropdownButtonFormField<String>(
          //     value: selectedKatagori,
          //     onChanged: (newValue) {
          //       setState(() {
          //         selectedKatagori = newValue!;
          //       });
          //     },
          //     items: <String>['Pria', 'Wanita', 'Anak']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //     decoration: const InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Kategori Product',
          //     ),
          //   ),
          // ),
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
              child: const Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }
}
