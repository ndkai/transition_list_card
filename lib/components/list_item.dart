import 'package:animation_list/components/detailed_page.dart';
import 'package:flutter/material.dart';

import '../models/location.dart';

class ListItem extends StatefulWidget {
  final Location location;

  const ListItem({super.key, required this.location});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with TickerProviderStateMixin {
  late AnimationController _movingController;
  late AnimationController _sizeController;
  late Animation<double> _movingAnimation;
  late Animation<double> _sizeAnimation;

  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    _movingController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _sizeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _movingAnimation =
        Tween<double>(begin: 0, end: 100).animate(_movingController);
    _sizeAnimation = Tween<double>(begin: 0, end: 20).animate(_sizeController);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: Listenable.merge([_movingController, _sizeController]),
        builder: (context, child) {
          return Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailedPage(location: widget.location)));
                },
                child: AnimatedBuilder(
                  animation: _sizeAnimation,
                  builder: (context, child){
                    return Container(
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal: 20  - _sizeAnimation.value),
                      width: size.width,
                      height: 500 ,
                      child: Column(
                        children: [
                          Text(
                            widget.location.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.location.address,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _movingController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()..translate(0, -_movingAnimation.value),
                    child: InkWell(
                      onTap: (){
                        if(isExpand){
                          reverseAnimation();
                        } else {
                          forwardAnimation();
                        }
                        isExpand = !isExpand;
                      },
                      child: Hero(
                        tag: "image",
                        child: Container(

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(widget.location.image),
                                  fit: BoxFit.fill)),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
                          height: 500,
                          child: Column(
                            children: [
                              Text(
                                widget.location.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                widget.location.address,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

  void reverseAnimation(){
    _movingController.reverse();
    _sizeController.reverse();
  }

  void forwardAnimation(){
    _movingController.forward();
    _sizeController.forward();
  }

}
