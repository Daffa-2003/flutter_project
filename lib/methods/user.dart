class User {
  final int id;
  final String nik;
  final String name;
  final String email;
  final String password;
  final int role;
  final String alamat;
  final String foto;
  final String tlp;
  final String tglLahir;

  User(
      {required this.id,
      required this.nik,
      required this.name,
      required this.email,
      required this.password,
      required this.role,
      required this.alamat,
      required this.foto,
      required this.tlp,
      required this.tglLahir});

  factory User.formJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        nik: json['nik'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        alamat: json['alamat'],
        foto: json['foto'],
        tlp: json['tlp'],
        tglLahir: json['tglLahir']);
  }
}
