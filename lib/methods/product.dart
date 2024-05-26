class Product {
  final int id;
  final String name;
  final String type;
  final String kategori;
  final int quantity;
  final String harga;
  final String foto;

  Product(
      {required this.id,
      required this.name,
      required this.type,
      required this.kategori,
      required this.quantity,
      required this.harga,
      required this.foto});

  factory Product.formJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        kategori: json['kategori'],
        quantity: json['quantity'],
        harga: json['harga'].toString(),
        foto: json['foto']);
  }
}
