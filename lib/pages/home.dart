import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/models/category_models.dart';
import 'package:news_updates/models/slider_modal.dart';
import 'package:news_updates/services/data.dart';
import 'package:news_updates/services/news.dart';
import 'package:news_updates/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModels> categories = [];
  List<sliderModal> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    sliders = getSlider();
    super.initState();

    getNews();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text(
              "Feed",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTiles(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Breaking News!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text("View All",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CarouselSlider.builder(
                        itemCount: sliders.length,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].image;
                          String? res2 = sliders[index].name;
                          return builImage(res!, index, res2!);
                        },
                        options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            })),
                    SizedBox(height: 30.0),
                    Center(child: buildIndicator()),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trending News!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          Text("View All",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageUrl: articles[index].urlToImage!,
                            title: articles[index].title!,
                            desc: articles[index].description!);
                      },
                    )),
                  ],
                ),
              ),
            ),
    );
  }

  Widget builImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(image,
              fit: BoxFit.cover,
              height: 250,
              width: MediaQuery.of(context).size.width),
        ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10.0),
          margin: EdgeInsets.only(top: 170.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]));
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: ExpandingDotsEffect(activeDotColor: Colors.green),
      );
}

class CategoryTiles extends StatelessWidget {
  final String? image;
  final String? categoryName;

  const CategoryTiles({Key? key, this.image, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:
                Image.asset(image!, width: 120, height: 60, fit: BoxFit.cover),
          ),
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.black38),
            child: Center(
                child: Text(categoryName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc;
  BlogTile({required this.imageUrl, required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Define the action to perform on tap
        print('Padding tapped');
        // You can navigate to another screen or perform any other action here
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          maxLines: 2,
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                      ),
                      SizedBox(height: 9.0),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          maxLines: 3,
                          desc,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
