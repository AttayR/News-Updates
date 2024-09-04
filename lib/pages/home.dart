import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/models/category_models.dart';
import 'package:news_updates/models/slider_modal.dart';
import 'package:news_updates/pages/article_submission_screen.dart';
import 'package:news_updates/pages/article_view.dart';
import 'package:news_updates/pages/category_news.dart';
import 'package:news_updates/pages/news_page.dart';
import 'package:news_updates/pages/offline_news_screen.dart';
import 'package:news_updates/pages/privacy_policy.dart';
import 'package:news_updates/pages/quiz_screen.dart';
import 'package:news_updates/pages/submitted_article_screen.dart';
import 'package:news_updates/services/data.dart';
import 'package:news_updates/services/news.dart';
import 'package:news_updates/services/slider_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModels> categories = [];
  List<sliderModal> sliders = [];
  List<ArticleModel> articles = [];
  Set<String> _bookmarkedArticleIds = Set<String>();
  bool _loading = true;
  int activeIndex = 0;
  late String currentTime;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
    categories = getCategories();
    getSlider();
    getNews();
    _updateTime();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedArticleIds =
          prefs.getStringList('bookmarkedArticles')?.toSet() ?? Set<String>();
    });
  }

  Future<void> _toggleBookmark(ArticleModel article) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_bookmarkedArticleIds.contains(article.id)) {
        _bookmarkedArticleIds.remove(article.id);
      } else {
        _bookmarkedArticleIds.add(article.id as String);
      }
      prefs.setStringList('bookmarkedArticles', _bookmarkedArticleIds.toList());
    });
  }

  Future<void> getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    setState(() {
      articles = newsclass.news;
      _loading = false;
    });
  }

  Future<void> getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    setState(() {
      sliders = slider.sliders;
    });
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat('hh:mm a').format(DateTime.now());
    });
    Future.delayed(Duration(seconds: 60), _updateTime);
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }

  void _showCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 80, 2, 2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 10.0),
              ...categories.map((category) {
                return ListTile(
                  leading: Image.asset(
                    category.image ?? '',
                    width: 120,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    category.categoryName ?? 'Unknown',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    final parentContext = context;
                    Navigator.pop(context);
                    Navigator.push(
                        parentContext,
                        MaterialPageRoute(
                            builder: (context) => CategoryNews(name: 'News')));
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleSubmissionScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubmittedArticlesScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 80, 2, 2), // Background color
        iconTheme: IconThemeData(
          color: Colors.white, // Color of the icons
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.offline_pin_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfflineNewsScreen()),
              );
            },
          ),
        ],
        title: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "World",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: " Pulse",
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 80, 2, 2),
              ),
              child: Text(
                'Menu',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.wrong_location_rounded),
              title: Text(
                "Global",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.orange,
                    ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text(
                "Submitted Articles",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.orange,
                    ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubmittedArticlesScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.article_rounded),
              title: Text(
                "Write Articles",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.orange,
                    ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleSubmissionScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.offline_pin),
              title: Text(
                "Offline Articles",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.orange,
                    ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfflineNewsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text(
                "Privacy Policy",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.orange,
                    ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 80, 2, 2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
            backgroundColor: Color.fromARGB(255, 80, 2, 2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Write Article',
            backgroundColor: Color.fromARGB(255, 80, 2, 2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Submitted Article',
            backgroundColor: Color.fromARGB(255, 80, 2, 2),
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Category!",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTiles(
                            image: categories[index].image,
                            categoryName:
                                categories[index].categoryName ?? 'Unknown',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(child: buildIndicator()),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Headlines!",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: articles.isEmpty
                          ? Center(child: Text("No headlines available"))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                final article = articles[index];
                                final isBookmarked =
                                    _bookmarkedArticleIds.contains(article.id);
                                return BlogTile(
                                  imageUrl: articles[index].urlToImage ?? '',
                                  title: articles[index].title ?? '',
                                  desc: articles[index].description ?? '',
                                  url: articles[index].url ?? '',
                                  author: articles[index].author ?? 'Anonymous',
                                  publishedAt:
                                      articles[index].publishedAt ?? '',
                                );
                                
                              },
                              
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: 250,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset("/images/building4.jpg"),
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 10.0),
              margin: EdgeInsets.only(top: 170.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                name,
                maxLines: 1,
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 174, 0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: ExpandingDotsEffect(activeDotColor: Colors.orange),
      );
}

extension on TextTheme {
  get headline6 => null;
}

class CategoryTiles extends StatelessWidget {
  final String? image;
  final String categoryName;

  CategoryTiles({Key? key, this.image, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image ?? '',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName ?? 'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(15),
          shadowColor: Colors.black.withOpacity(0.5),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    desc,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'By $author',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
