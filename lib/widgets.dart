import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/home.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, discription, url;

  const BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.discription,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            //image
            Container(
              padding: EdgeInsets.only(top: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),

            //title
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),

            //description
            Padding(padding: EdgeInsets.only(bottom: 2)),
            Text(discription, style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName, country;

  CategoryTile({this.imageUrl, this.categoryName, this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(categoryName);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      country: country,
                      categories: categoryName,
                    )));
      },
      child: Container(
          child: Stack(
        children: [
          //categories
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
