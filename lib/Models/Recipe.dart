class RecipeModel {
  List<Recipe> data;

  RecipeModel({this.data});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Recipe>();
      json['data'].forEach((v) {
        data.add(new Recipe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipe{
  int likes;
  double rating;
  int ratingCount;
  List<String> ingredients;
  List<String> steps;
  String sId;
  String title;
  String userID;
  bool isVeg;
  double time;
  String recipePic;
  String creationDate;
  int iV;

  Recipe(
      {this.likes,
      this.rating,
      this.ratingCount,
      this.ingredients,
      this.steps,
      this.sId,
      this.title,
      this.userID,
      this.isVeg,
      this.recipePic,
      this.time,
      this.creationDate,
      this.iV});

  Recipe.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    rating = json['rating'].toDouble();
    ratingCount = json['ratingCount'];
    ingredients = json['ingredients'].cast<String>();
    steps = json['steps'].cast<String>();
    sId = json['_id'];
    title = json['title'];
    userID = json['userID'];
    isVeg = json['is_veg'];
    time =  json['time'].toDouble();
    recipePic = json['recipePic'];
    creationDate = json['creation_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['rating'] = this.rating;
    data['ratingCount'] = this.ratingCount;
    data['ingredients'] = this.ingredients;
    data['steps'] = this.steps;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['userID'] = this.userID;
    data['is_veg'] = this.isVeg;
    data['time'] = this.time;
    data['recipePic'] = this.recipePic;
    data['creation_date'] = this.creationDate;
    data['__v'] = this.iV;
    return data;
  }
}