// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

RecipeModel recipeModelFromJson(String str) => RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  String title;
  double version;
  String href;
  List<Result> results;

  RecipeModel({
    this.title,
    this.version,
    this.href,
    this.results,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    title: json["title"],
    version: json["version"].toDouble(),
    href: json["href"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "version": version,
    "href": href,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String title;
  String href;
  String ingredients;
  String thumbnail;

  Result({
    this.title,
    this.href,
    this.ingredients,
    this.thumbnail,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    href: json["href"],
    ingredients: json["ingredients"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "href": href,
    "ingredients": ingredients,
    "thumbnail": thumbnail,
  };
}
