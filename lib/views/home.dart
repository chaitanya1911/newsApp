import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/widgets.dart';

class Home extends StatefulWidget {
  final String categories, country;

  const Home({this.country, this.categories});
  @override
  _HomeState createState() => _HomeState(country: country);
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  final String country;

  _HomeState({this.country});
  @override
  void initState() {
    super.initState();

    categories = getCategories();
    getClassNews(widget.categories, widget.country);
  }

  getClassNews(String category, String country) async {
    News newsClass = News();
    await newsClass.getNews(
        "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=9477cd78b9c34c8c978b054a434eee78");
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Select Country'),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text('US'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              categories: 'business',
                              country: 'us',
                            )));
              },
            ),
            ListTile(
              title: Text('India'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              categories: 'business',
                              country: 'in',
                            )));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ///categories
                  Container(
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            country: country,
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),

                  //Blogs
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  url: articles[index].url,
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  discription: articles[index].description);
                            })),
                  )
                ],
              ),
            ),
    );
  }
}
