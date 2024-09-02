import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/models/show_category.dart';
import 'package:news_updates/pages/article_view.dart';
import 'package:news_updates/services/show_categories_news.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoryNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories.cast<ShowCategoryModel>();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 80, 2, 2),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: categories.isEmpty
              ? Center(child: Text("No headlines available"))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                      image: categories[index].urlToImage ?? '',
                      title: categories[index].title ?? '',
                      desc: categories[index].description ?? '',
                      author: categories[index].author ?? '',
                      url: categories[index].url ?? '',
                    );
                  },
                ),
        ));
  }
}

class ShowCategory extends StatelessWidget {
  final String image;
  final String desc;
  final String title;
  final String author;
  final String url;

  ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.author,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url,)));
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                    'images/building4.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              textAlign: TextAlign.center,
              desc,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            Text(
              textAlign: TextAlign.center,
              'author : ${author}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
