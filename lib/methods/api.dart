import 'dart:convert';

import 'package:flutter_project/helper/constand.dart';
import 'package:flutter_project/methods/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  Future<http.Response> postRequest({
    required String route,
    required Map<String, dynamic> data,
  }) async {
    String url = apiUrl + route;
    try {
      final headers = await _header();
      return await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      // Mengembalikan response dengan status gagal
      return http.Response(jsonEncode({'error': e.toString()}), 500);
    }
  }

  Future<Map<String, String>> _header() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}

class OUT {
  postRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    String url = apiUrl + route;
    try {
      return await http.get(
        Uri.parse(url),
        headers: await _header(),
      );
    } catch (e) {
      print(e.toString());
      return jsonEncode(e);
    }
  }

  Future<Map<String, String>> _header() async {
    String? token = await _getTokenFromSharedPref();
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<String?> _getTokenFromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}

class ProductService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/auth/getData';
  static Future<List<Product>> getProduct() async {
    try {
      final response = await http.get(Uri.parse('baseUrl'));
      final body = response.body;
      final result = jsonDecode(body);
      List<Product> products = List<Product>.from(
        result['data'].Map(
          (product) => Product.formJson(product),
        ),
      );
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class DeleteData {
  Future<http.Response> postRequest({
    required String route,
    required Map<String, dynamic> data,
  }) async {
    String url = apiUrl + route;
    try {
      final headers = await _header();
      return await http.delete(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      return http.Response(jsonEncode({'error': e.toString()}), 500);
    }
  }

  Future<Map<String, String>> _header() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> deleteRequest({
    required String route,
  }) async {
    String url = apiUrl + route;
    try {
      final headers = await _header();
      return await http.delete(
        Uri.parse(url),
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      return http.Response(jsonEncode({'error': e.toString()}), 500);
    }
  }
}
