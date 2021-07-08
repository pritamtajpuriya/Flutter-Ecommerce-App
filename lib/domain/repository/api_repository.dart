import 'package:sajilo_dokan/domain/model/cart.dart';
import 'package:sajilo_dokan/domain/model/product.dart';
import 'package:sajilo_dokan/domain/model/product_comment.dart';
import 'package:sajilo_dokan/domain/request/login_request.dart';
import 'package:sajilo_dokan/domain/request/register_request.dart';
import 'package:sajilo_dokan/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<LoginResponse> getUserFromToken(String token);

  Future<LoginResponse> login(LoginRequest login);
  Future<LoginResponse> register(RegisterRequest register);

  Future<void> logout(String token);
  Future<List<Product>> fetchingProdcut(String token);

  Future getCategories();
  Future<List<Product>> getCategorieProduct(String categoryName);
  Future<List<Cart>> getCartList(String token);
  Future<bool> addToCart(String token, int id);
  Future<bool> deleteCart(String token, int id);
  Future<bool> makeFavorite(String token, int id);
  Future<List<ProductComment>> getComments(String token, int id);
  Future<bool> likeComment(String token, int id);
  Future<bool> dislikeComment(String token, int id);
  Future<bool> addQuanity(String token, int id, int quantity);

  Future<LoginResponse> googleSignIn(String idToken);
}
