import 'package:flutter/material.dart';
import 'package:news_updates/pages/submitted_article_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleSubmissionScreen extends StatefulWidget {
  @override
  _ArticleSubmissionScreenState createState() =>
      _ArticleSubmissionScreenState();
}

class _ArticleSubmissionScreenState extends State<ArticleSubmissionScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _submitArticle() async {
    // Retrieve the input text
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final articles = prefs.getStringList('submitted_articles') ?? [];
      articles.add('$title: $content');
      await prefs.setStringList('submitted_articles', articles);
      print('Saved Articles: ${prefs.getStringList('submitted_articles')}');

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Article Submitted'),
          content: Text('Your article has been submitted successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
                _titleController.clear();
                _contentController.clear();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 80, 2, 2),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: " Article",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.subscriptions),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubmittedArticlesScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _contentController,
                
                decoration: InputDecoration(
                  
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                maxLines: 10,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: _submitArticle,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: const Color.fromARGB(255, 80, 2, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
