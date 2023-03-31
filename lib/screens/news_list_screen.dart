import 'package:flutter/material.dart';
import 'package:myflutterproject/widgets/mainDrawer.dart';
import '../models/news_model.dart';

class NewsListScreen extends StatelessWidget {
  static const routeName="/news-list-screen";
  final List<News> news = [
    News(
      title: 'Child Trafficking',
      imageUrl: 'https://media.indiatimes.in/media/content/2016/Nov/4_1480152983.jpg',
      description: 'This child was found making bricks in brick klin in jaipur.',
    ),
    News(
      title: 'Robbery',
      imageUrl: 'https://thumbs.dreamstime.com/z/robbery-17504142.jpg',
      description: 'This robberer was caught from the jaipur central bank.',
    ),
    News(
      title: 'Road Rage',
      imageUrl: 'https://s-i.huffpost.com/gen/1839108/thumbs/o-ROAD-RAGE-570.jpg?6',
      description: 'Road raging was prevented on the jaipur delhi expressway',
    ),
    // News(
    //   title: 'Entertainment',
    //   imageUrl: 'https://example.com/entertainment-news.jpg',
    //   description: 'ENTERTAINMENT',
    // ),
  ];

  NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: 
    ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(news[index].imageUrl),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(news[index].title),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(news[index].description),
              ),
            ),
          );
        },
      )
    );
  }
}
