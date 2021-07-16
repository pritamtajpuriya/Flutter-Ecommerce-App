import 'dart:convert';

import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/domain/model/product_comment.dart';

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

  static Map<String, String> header(String token) => {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

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
    var result = await client.get(getMainUrl('/api/products/'),
        headers: token != null ? header(token) : null);
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
    var result = await client.get(getMainUrl('/api/carts/'),
        headers: token != null ? header(token) : null);
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

  @override
  Future<List<ProductComment>> getComments(String token, int id) async {
    var result = await client.get(getMainUrl('/api/comments/$id'),
        headers: token != null ? header(token) : null);
    var jsonData = result.body;
    // print(jsonData);
    if (result.statusCode == 200) {
      return productCommentFromJson(jsonData);
    } else
      return null;
  }

  @override
  Future<bool> dislikeComment(String token, int id) async {
    var result = await client.post(getMainUrl('/api/dislike/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    print(result);
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> likeComment(String token, int id) async {
    var result = await client.post(getMainUrl('/api/like/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    print(result.body);

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> addQuanity(String token, int id, int quantity) async {
    print('Add Quantity');
    print('$token, $id, $quantity');
    var result = await client.post(getMainUrl('/api/add-quantity/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id",
      "quantity": "$quantity"
    });
    print('Add Quantity');

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<LoginResponse> googleSignIn(String idToken, String provider) async {
    var result =
        await client.post(getMainUrl('/social_auth/$provider/'), body: {
      "auth_token": idToken,
    });
    print('GoogleSignIn');
    if (result.statusCode == 200) {
      var jsondata = result.body;

      return loginResponseFromJson(jsondata);
    } else {
      return null;
    }
  }

  @override
  Future<bool> forgetPassword(String email) async {
    print(email);
    var result = await client
        .patch(getMainUrl('/api/forget-password'), body: {"email": "$email"});

    print(result.body);
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> verifyForgetPasswordCode(String email, String otp) async {
    var result = await client.post(getMainUrl('/api/forget-password'),
        body: {"email": "$email", "otp": "$otp"});
    var data = result.body;
    var dd = jsonDecode(data);

    if (result.statusCode == 200) {
      return dd['token'];
    }
    return null;
  }

  @override
  Future<LoginResponse> createNewPassword(
      String token, String newPassword) async {
    var queryParameters = {
      'q': '{https}',
      'token': '$token',
    };
    var uri = Uri.https(
      'onlinehatiya.herokuapp.com',
      '/api/change-password',
      queryParameters,
    );
    var result = await client.post(uri, body: {"new_password": "$newPassword"});
    print(newPassword);
    print(result.body);
    if (result.statusCode == 200) {
      var jsondata = result.body;
      print(jsondata);
      return loginResponseFromJson(jsondata);
    }
    return null;
  }
}
