import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_updates/models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];
bool isValidUrl(String url) {
  return Uri.tryParse(url)?.hasAbsolutePath ?? false;
}

  Future<void> getCategoryNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=4c908d3c8db540508541bc576144355f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        String imageUrl = element["urlToImage"] ?? "images/building7.jpg";
        if (!isValidUrl(imageUrl)) {
          imageUrl = "images/building7.jpg";
        }
        ShowCategoryModel categoryModel = ShowCategoryModel(
          title: element["title"] ?? "No Title",
          description: element["description"] ?? "No Description Available",
          url: element["url"] ?? "",
          urlToImage: imageUrl,
          content: element["content"] ?? "",
          author: element["author"] ?? "Unknown",
        );
        categories.add(categoryModel);
      });
    }
  }
}
