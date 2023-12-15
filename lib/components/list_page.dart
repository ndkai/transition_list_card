import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/location.dart';
import 'list_item.dart';

var locations = <Location>{
  Location(name: 'Lăng Chủ Tịch', address: "Việt Nam", image: "assets/langchutich.jpg", decription: ""),
  Location(name: 'Phố Cổ', address:"Việt Nam", image: "assets/phoco.jpg", decription: ""),
  Location(name: 'Sun World', address:"Việt Nam", image: "assets/sunworld.jpg", decription: ""),
  Location(name: 'Văn miếu', address:"Việt Nam", image: "assets/vanmieu.jpg", decription: ""),
};

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return CarouselSlider(
      options: CarouselOptions(height: 700.0),
      items: locations.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Center(
              child: ListItem(location: i),
            );
          },
        );
      }).toList(),
    );
  }


}
