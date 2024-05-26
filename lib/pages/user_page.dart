import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/methods/api.dart';
import 'package:flutter_project/methods/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];

  late SharedPreferences preferences;
  bool isLoading = false;

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
    getUser();
  }

  void getUser() async {
    setState(() {
      isLoading = true;
    });
    final response = await OUT().postRequest(route: '/getUser', data: {});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData != null && responseData['status'] == 200) {
        List<User> fetchedProducts = [];
        for (var item in responseData['data']) {
          fetchedProducts.add(User.formJson(item));
        }
        if (!mounted) return;
        setState(() {
          users = fetchedProducts;
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

  void deleteProduct(int id) async {
    final response = await DeleteData()
        .postRequest(route: '/deleteUser/$id', data: {'id': id});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        getUser();
      }
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const (),
                        //   ),
                        // );
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ),
              const Text(
                "Daftar User",
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
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
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
                                // image: const DecorationImage(
                                //   image: NetworkImage(
                                //       'https://w7.pngwing.com/pngs/885/113/png-transparent-brown-trouser-khaki-trousers-mens-pant-active-pants-beige-clothing-thumbnail.png'), // Ganti dengan path gambar produk dari objek user
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            title: Text(
                              "coba",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // subtitle: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       user.email,
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.grey[600],
                            //       ),
                            //     ),
                            //     const SizedBox(height: 4),
                            //     Text(
                            //       "Role :${user.role}",
                            //       style: const TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     const SizedBox(height: 4),
                            //     Text(
                            //       "Alamat: ${user.alamat}",
                            //       style: const TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.red,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.brush_outlined),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteProduct(user.id);
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
