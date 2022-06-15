import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Super Mario',
          style: TextStyle(fontSize: 30, fontFamily: "SuperMario"),
        ),
      ),
      body: Stack(children: [
        Positioned(
          top: 185,
          child: Row(children: [
            SizedBox(
                child: Image.asset('assets/images/land.png',
                    height: 92, fit: BoxFit.fitWidth)),
            SizedBox(
              child: Image.asset('assets/images/land.png',
                  height: 92, fit: BoxFit.fitWidth),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 140, top: 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/flower.png', height: 60),
              Image.asset('assets/images/flower.png', height: 70),
              Image.asset('assets/images/flower.png', height: 50),
            ],
          ),
        ),
        Positioned(
          top: 115,
          left: 40,
          child: Image.asset('assets/images/mario.png', height: 100),
        ),
      ]),
    );
  }
}
