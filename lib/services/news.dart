import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/models/db_helper.dart';

class News {
  List<ArticleModel> news = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-08-03&sortBy=publishedAt&apiKey=4c908d3c8db540508541bc576144355f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      List<ArticleModel> newArticles = [];
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
            publishedAt: element["publishedAt"],
          );
          newArticles.add(articleModel);
        }
      });
      
      // Save articles to local storage
      for (var article in newArticles) {
        await _dbHelper.insertArticle(article);
      }
      
      // Update news list with fetched articles
      news = newArticles;
    }
  }

  Future<void> fetchLocalArticles() async {
    // Fetch articles from local storage
    news = await _dbHelper.fetchArticles();
  }
}
