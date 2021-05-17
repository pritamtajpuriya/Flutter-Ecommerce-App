import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sajilo_dokan/domain/exception/auth_exception.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/domain/model/user.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl extends ApiRepositoryInterface {
  static var client = http.Client();

  static Uri getUrl(String endpoind, {String baseUrl = 'fakestoreapi.com'}) {
    var url = Uri.https('${(baseUrl)}', '${(endpoind)}', {'q': '{https}'});
    return url;
  }

  static Uri getMainUrl(String endpoind,
      {String baseUrl = 'onlinehatiya.herokuapp.com'}) {
    var url = Uri.https('${(baseUrl)}', '${(endpoind)}', {'q': '{https}'});
    return url;
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerRequest) async {
    print('register');
    var result = await client.post(getMainUrl('/api/register/'), body: {
      "name": registerRequest.name,
      "email": registerRequest.email,
      "password": registerRequest.password
    });
    print('register');
    if (result.statusCode == 200) {
      var jsondata = result.body;
      print('Register');
      return loginResponseFromJson(jsondata);
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponse> getUserFromToken(String token) async {
    var result = await client.get(getMainUrl('/api/user/profile/'), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('login');
      print(jsonData);
      return loginResponseFromJson(jsonData);
    } else {
      return null;
    }

    // if (token == 'AA111') {
    //   return User(name: 'Pritam Taj', username: 'pritamtaj', images: '');
    // } else if (token == 'AA222') {
    //   return User(
    //       name: 'TekRaj Guragain', username: 'tekrajguragain', images: '');
    // }
    // throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    var result = await client.post(getMainUrl('/api/login/'),
        body: {'email': login.email, 'password': login.password});

    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('login');
      print(jsonData);
      return loginResponseFromJson(jsonData);
    } else {
      return null;
    }
    // if (login.username == 'pritam@' && login.password == 'pritamtaj') {
    //   return LoginResponse(
    //       'AA111',
    //       User(
    //           name: 'Pritam Taj',
    //           username: 'pritamtaj',
    //           images: 'assets/images/pritam.jpg'));
    // } else if (login.username == 'tek' && login.password == 'tekraj') {
    //   return LoginResponse(
    //       'AA222',
    //       User(
    //           name: 'TekRaj Guragain',
    //           username: 'tekrajguragain',
    //           images: 'assets/images/tekraj.jpg'));
    // }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('removing token');
    return;
  }

  @override
  Future<List<Product>> fetchingProdcut() async {
    var url =
        Uri.https('fakestoreapi.herokuapp.com', '/products', {'q': '{https}'});

    var result = await client.get(getUrl('/products'));
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('Fetch product called');
      return productFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future getCategories() async {
    List<String> purpleListFromJson(String str) =>
        List<String>.from(json.decode(str).map((x) => x));

    var result = await client.get(getUrl('/products/categories'));

    var jsonData = result.body;
    print('Get Category List called');

    if (result.statusCode == 200) {
      return purpleListFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<Product>> getCategorieProduct(String categoryName) async {
    var url = Uri.https('fakestoreapi.herokuapp.com',
        '/products/category/${(categoryName)}', {'q': '{https}'});

    var result =
        await client.get(getUrl('/products/category/${(categoryName)}'));
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('CategoryProducts call');

      return productFromJson(jsonData);
    } else {
      return null;
    }
  }
}
