import 'dart:convert';

import 'package:market_app/model/items_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static String base = '10.0.2.2:8080';
  static String productPath = '/products';
  static String recommendedPath = '/recommended-products';
  static String checkOutPath = '/orders/checkout';

  static Future<Items> getProducts() async {
    var getUri = Uri.http(base, productPath);
    var response = await http.get(getUri);
    var decode = jsonDecode(response.body);
    Items res = Items(items: [Item(id: 0, name: 'cake', price: 200)]);
    // Items res = Items.fromJson(decode);
    return res;
  }

  static Future<List<Item>> getRecommend() async {
    var getUri = Uri.http(base, recommendedPath);
    var response = await http.get(getUri);

    List<Item> res = [];
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      res = Item.fromJsonList(decode);
    }
    return res;
  }

  static Future<bool> postCheckout() async {
    var getUri = Uri.http(base, checkOutPath);
    bool res = true;
    var body = jsonEncode({
      "products": [0]
    });
    var response = await http.post(
      getUri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 204) {
      res = false;
    }

    return res;
  }
}
