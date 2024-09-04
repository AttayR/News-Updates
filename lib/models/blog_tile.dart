import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, author, publishedAt;

  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
    required this.author,
    required this.publishedAt,
  });

  Future<void> _saveArticle() async {
    final article = {
      'imageUrl': imageUrl,
      'title': title,
      'desc': desc,
      'url': url,
      'author': author,
      'publishedAt': publishedAt,
    };

    final prefs = await SharedPreferences.getInstance();
    List<String>? savedArticles = prefs.getStringList('saved_articles') ?? [];
    savedArticles.add(json.encode(article));
    await prefs.setStringList('saved_articles', savedArticles);

   
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(Icons.article, size: 50),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          desc,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: _saveArticle,
        ),
        onTap: () {
          // Navigate to article details if needed
        },
      ),
    );
  }
}
