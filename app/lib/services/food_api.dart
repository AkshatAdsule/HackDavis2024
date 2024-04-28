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
        dt = json.decode(response.body);
        print('Response body: ${response.body}');

        FoodData foodData = FoodData(
          name: dt!['hints'][0]['food']["label"],
          image: dt!['hints'][0]['food']["image"],
          score: calculateScore(),
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

  double calculateScore() {
    if (dt == null) {
      return -8;
    }
    Map<String, dynamic> dataB = dt!;

    double calories = dataB['hints']?[0]?['food']?["nutrients"]?["CA"] ?? 100;
    double protein = dataB['hints']?[0]?['food']?["nutrients"]?["PROCNT"] ?? 10;
    double fat = dataB['hints']?[0]?['food']?["nutrients"]?["FAT"] ?? 5;
    double sugar = dataB['hints']?[0]?['food']?["nutrients"]?["SUGAR"] ?? 10;
    // Calculate dataB calories
    double totalCalories = calories;

    // Calculate percentage of calories from fat, sugar, and protein
    double fatPercentage = (fat / totalCalories) * 100;
    double sugarPercentage = (sugar / totalCalories) * 100;
    double proteinPercentage = (protein * 20 / totalCalories) *
        100; // Protein contributes 4 calories per gram

    // Score for fat (scaling exponentially)
    double fatScore = 0;
    if (fatPercentage <= 20) {
      fatScore = 10 - (20 - fatPercentage) / 2;
    } else {
      fatScore = 5 - (fatPercentage) / 5;
    }
    fatScore = (fatScore).clamp(-2, 4); // Ensure score is within range [2, 10]

    // Score for sugar (scaling exponentially)
    double sugarScore = 0;
    if (sugarPercentage <= 10) {
      sugarScore = (10 - (10 - sugarPercentage) / 2).clamp(3, 10);
    } else {
      sugarScore = 3 - (sugarPercentage) / 6;
    }
    sugarScore =
        (sugarScore).clamp(-4, 5); // Ensure score is within range [2, 10]

    // Score for protein (scaled based on percentage of calories)
    double proteinScore =
        (proteinPercentage / 10).clamp(0, 15); // Scale protein to 0-10 range
    proteinScore = proteinScore.clamp(0, 10);

    // Combine scores with a larger portion for calories/protein
    double totalScore =
        ((calories / 100) + proteinScore / 4 + (fatScore + sugarScore) / 2);

    // Ensure score is within the range [2, 10]
    if (totalScore < 2) {
      totalScore = 2;
    } else if (totalScore > 14) {
      totalScore = 14;
    }

    return totalScore;
  }
}
