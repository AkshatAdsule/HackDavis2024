import 'dart:async';
import 'dart:convert';

import 'package:app/util/food_data.dart';
import 'package:http/http.dart' as http;

class FoodApi {
  String apiUrl =
      'https://edamam-food-and-grocery-database.p.rapidapi.com/api/food-database/v2/';
  Map<String, String> headers = {
    'X-RapidAPI-Key': 'ad41d445dcmshf30b0fbe28832eap15f08bjsnc10de322e74a',
    'X-RapidAPI-Host': 'edamam-food-and-grocery-database.p.rapidapi.com'
  };

  Map<String, dynamic>? dt = null;

  Future<FoodData?> getResponse(int brCode) async {
    String url = apiUrl + brCode.toString();
    Uri uri = Uri(
        scheme: 'https',
        host: 'edamam-food-and-grocery-database.p.rapidapi.com',
        path: '/api/food-database/v2/parser',
        queryParameters: {
          'upc': brCode.toString(),
          // 'category': "[\"generic-foods\"]",
        });
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        // Handle successful response here
        Map<String, dynamic> dt = json.decode(response.body);
        print('Response body: ${response.body}');

        FoodData foodData = FoodData(
          name: dt['hints'][0]['food']["label"],
          image: dt['hints'][0]['food']["image"],
          score: 0,
          quantity: 1,
        );

        return foodData;
      } else {
        // Handle errors or non-200 status codes
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occurred during the request
      print('Error sending request: $error');
      dt = null;
      return null;
    }
  }

  // bool isFood() {
  //   if (dt != null) {
  //     Map<String, dynamic> data = dt!;
  //     if (data.containsKey('product')) {
  //       Map<String, dynamic> product = data['product'];
  //       if (product.containsKey('category')) {
  //         String? product = product['category'];
  //         if ()
  //       }
  //     }
  //   }
  //   return false;
  // }
}
