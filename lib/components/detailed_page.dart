import 'package:animation_list/models/location.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatelessWidget {
  final Location location;
  const DetailedPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Hero(tag: "image",

              child: Container(
            width: size.width,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(location.image),
                    fit: BoxFit.fill
                )
            ),
          )),
          Expanded(child: Container(color: Colors.tealAccent,))
        ],
      ),
    );
  }
}
