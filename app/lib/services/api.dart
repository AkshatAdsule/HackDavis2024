import 'dart:convert';

import 'package:app/services/user_service.dart';
import 'package:app/util/food_data.dart';
import 'package:app/util/item.dart';
import 'package:app/util/user.dart';
import 'package:http/http.dart';

class APIService {
  static APIService? _instance;

  final api_base_url = 'http://192.168.185.239:3000';

  static APIService get instance {
    _instance ??= APIService._();
    return _instance!;
  }

  APIService._();

  Future<List<Item>> getFreedgeItems(int id) async {
    Uri uri = Uri.parse("$api_base_url/freedge/$id");
    Response response = await get(uri);

    Map<String, dynamic> data = json.decode(response.body);

    List<Item> items = [];
    for (var item in data['items']) {
      items.add(Item.fromJson(item));
    }

    return items;
  }

  Future<void> addItems(int freedgeId, List<FoodData> items) async {
    Uri uri = Uri.parse("$api_base_url/freedge/$freedgeId");
    String uid = UserService.instance.currentUser!.uid;

    for (FoodData item in items) {
      item.ownerId = uid;
      item.image ??= "NO_IMAGE_PROVIDED";
      await post(uri, body: json.encode(item.toJson()), headers: {
        'Content-Type': 'application/json',
      });
    }
  }

  Future<User> getUser(String uid) async {
    Uri uri = Uri.parse("$api_base_url/users/$uid");
    Response response = await get(uri);

    Map<String, dynamic> data = json.decode(response.body);

    return User.fromJson(data);
  }

  Future<List<User>> getLeaderBoard() async {
    Uri uri = Uri.parse("$api_base_url/users");
    Response response = await get(uri);

    List<User> users = [];
    for (var user in json.decode(response.body)) {
      users.add(User.fromJson(user));
    }

    return users;
  }

  Future<void> createUser(User user) async {
    Uri uri = Uri.parse("$api_base_url/users");

    await post(uri, body: json.encode(user.toJson()), headers: {
      'Content-Type': 'application/json',
    });
  }
}
