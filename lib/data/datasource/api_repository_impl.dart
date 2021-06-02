import 'dart:convert';

import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/model/product.dart';

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
      "Authorization": "Bearer $token"
    });
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('login');
      print(jsonData);
      return loginResponseFromJson(jsonData);
    } else {
      return null;
    }
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
  }

  @override
  Future<void> logout(String token) async {
    print('removing token');
    return;
  }

  @override
  Future<List<Product>> fetchingProdcut(String token) async {
    var result = await client.get(getMainUrl('/api/products/'), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
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
    List<String> categoryListFromJson(String str) =>
        List<String>.from(json.decode(str).map((x) => x));

    var result = await client.get(getMainUrl('/api/category/'));

    var jsonData = result.body;
    print('Get Category List called');

    if (result.statusCode == 200) {
      return categoryListFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<Product>> getCategorieProduct(String categoryName) async {
    var result = await client.post(getMainUrl('/api/category/'),
        body: {"category_name": "$categoryName"});
    if (result.statusCode == 200) {
      var jsonData = result.body;

      print('CategoryProducts call');

      return productFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<Cart>> getCartList(String token) async {
    var result = await client.get(getMainUrl('/api/carts/'), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('getCartList');

      return cartFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<bool> addToCart(String token, int id) async {
    var result = await client.post(getMainUrl('/api/carts/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteCart(String token, int id) async {
    var result = await client.post(getMainUrl('/api/deletecart/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> makeFavorite(String token, int id) async {
    var result = await client.post(getMainUrl('/api/makefavorite/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }
}
