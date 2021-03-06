import 'dart:io';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:recipedia/Models/Recipe.dart';
import '../Constants/Api.dart' as api;
import 'dart:convert';

class ApiProvider {
  final String baseUrl = api.baseURL;

  Future<List<Recipe>> getRecipes() async {
    final response = await http.get(baseUrl + '/getAll');
    if (response.statusCode == 200) {
      List<Recipe> temp = [];
      temp = RecipeModel.fromJson(json.decode(response.body)).data;
      // temp.add(Recipe.fromJson(json.decode(response.body)));
      return temp;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future getLikedRecipes(String userID) async {
    final response =
        await Dio().post(baseUrl + '/getLiked', data: {"userID": userID});
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        List<Recipe> temp = [];
        temp = RecipeModel.fromJson(response.data).data;
        print(temp);
        // temp.add(Recipe.fromJson(json.decode(response.body)));
        return temp;
      } else {
        return 0;
      }
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<void> createRecipe(File file, Map<String, dynamic> data) async {
    String fileName;
    Map finalData = data;
    if (file != null) {
      fileName = file.path.split('/').last;
      finalData['image'] =
          await MultipartFile.fromFile(file.path, filename: fileName);
    }

    //print(finalData);
    var formdata = FormData.fromMap(finalData);
    print(formdata.fields);
    // TO DO , ADD FILE UPLOAD
    //print(formdata);
    var response = await Dio().post(baseUrl + '/create', data: formdata);
    print(response);
    return null;
  }

  Future<void> logIn(String id, String username, String profileUrl) async {
    var response = await Dio().post(baseUrl + '/login',
        data: {'displayName': username, 'id': id, 'profileImg': profileUrl});
    print(response);
    return null;
  }

  Future<int> like(String recipeID, String userID) async {
    var response = await Dio()
        .post(baseUrl + '/like', data: {'id': recipeID, 'userID': userID});
    print(response);
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<void> rate(String recipeID, String userid, double rating) async {
    print(rating.toInt());
    var response = await Dio().post(baseUrl + '/rate',
        data: {'id': recipeID, 'userID': userid, 'rating': rating.toInt()});
    print(response);
    return null;
  }

  Future<List<Recipe>> searchRecipe(String query) async {
    final response = await http.get(baseUrl + '/search?q=' + query);
    print(response.body);
    if (json.decode(response.body)['error'] != null) {
      return Future.error(
          "Error Info", StackTrace.fromString("Recipe Not Found"));
    } else {
      List<Recipe> temp = [];
      temp = RecipeModel.fromJson(json.decode(response.body)).data;
      return temp;
    }
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to load');
    // }
  }

  Future getUser(String userID) async {
    final response =
        await Dio().post(baseUrl + '/getUser', data: {"userID": userID});
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
