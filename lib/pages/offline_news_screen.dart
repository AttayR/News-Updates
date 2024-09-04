import 'package:flutter/material.dart';
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/services/news.dart';
import 'package:intl/intl.dart';

class OfflineNewsScreen extends StatefulWidget {
  @override
  _OfflineNewsScreenState createState() => _OfflineNewsScreenState();
}

class _OfflineNewsScreenState extends State<OfflineNewsScreen> {
  final News _news = News();
  late Future<List<ArticleModel>> _offlineArticles;

  @override
  void initState() {
    super.initState();
    _offlineArticles = _news.fetchLocalArticles().then((_) => _news.news);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Offline",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: " News",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 80, 2, 2), // You can change this color to be more colorful

        iconTheme: IconThemeData(
          color:
              Colors.white, // This will change the color of the icons to white
        ),
        
      ),
      body: Container(
        child: FutureBuilder<List<ArticleModel>>(
          future: _offlineArticles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No offline news available.'));
            } else {
              final articles = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      leading: article.urlToImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                article.urlToImage!,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(Icons.article, size: 50),
                      title: Text(
                        article.title ?? 'No Title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        article.description ?? 'No Description',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        _showArticleDetails(context, article);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _showArticleDetails(BuildContext context, ArticleModel article) {
    final screenHeight = MediaQuery.of(context).size.height;
    final modalHeight = screenHeight * 0.6; // 80% of the screen height

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.white, // Set the background color of the modal to white
      builder: (context) {
        return Container(
          height: modalHeight, // Set the height of the modal
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Modal Heading
                  SizedBox(height: 16.0),

                  Text(
                    article.title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Optionally add a subtitle with the formatted date
                  Text(
                    "Published At: ${_formatDate(article.publishedAt ?? 'No Date')}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Image, if available
                  article.urlToImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            article.urlToImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.article, size: 100),
                  SizedBox(height: 16.0),

                  Text(
                    article.content ?? 'No Content',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formatter =
          DateFormat('MMM d, yyyy - h:mm a'); // Format: Sep 2, 2024 - 1:30 PM
      return formatter.format(date);
    } catch (e) {
      return 'No Date'; // Return a default value if the date is not parseable
    }
  }
}
