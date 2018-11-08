import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/Api.dart';
import '../model/PostData.dart';


class CategoryResponse {
  bool error;
  List<dynamic> results;

  CategoryResponse(this.error, this.results);

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    this.error = json['error'];
    this.results = json['results'];
  }
  Map<String, dynamic> toJson() => {
        'error': error,
        'results': results,
      };
}

class Networking {


  Future<List<PostData>> fetchArticles() async {
    var url = Api.TODAY_URL;    
    var response = await http.get(url);
    Map map = json.decode(response.body)["results"];
    List resultList = map["Android"];
    List<PostData> list = [];
    list = resultList.map((v) => PostData.fromJson(v)).toList();
    return list;
  }

  Future<String> getRequest(String url, [Map params]) async {
    http.Response response = await http.get(url, headers: params);
    return response.body.toString();
  }
  Future<CategoryResponse> getGankfromNet(String url) async {
    final responseStr = await getRequest(url);
    return toGankList(responseStr);
  }
  CategoryResponse toGankList(String responseStr) {
    return CategoryResponse.fromJson(jsonDecode(responseStr));
  }

}