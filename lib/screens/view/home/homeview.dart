
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationWallController;

  @override
  void initState() {
    super.initState();
    animationWallController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        upperBound: 350,
        lowerBound: 0);
    animationController = AnimationController(
      vsync: this,
      lowerBound: 120,
      upperBound: 200,
      duration: const Duration(seconds: 2),
    );

    animationWallController.forward();

    animationWallController.addListener(() {
      debugPrint(animationWallController.value.toString());
      if (animationWallController.value > 160 &&
          animationWallController.value < 250 &&
          animationController.value > 0 &&
          animationController.value < 170) {
        debugPrint('game over');
        animationController.stop();
        animationWallController.stop();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Game Over'),
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              animationWallController.reset();
                              animationWallController.forward();
                              animationController.forward();
                              animationController.reset();
                            },
                            child: const Text('One more time?'))
                      ],
                    )
                  ],
                ));
      }
      setState(() {});
    });

    animationController.addListener(() {
      // debugPrint('MARIO CANTROLLER >> ${animationController.value.toString()}');
      setState(() {});
    });

    animationWallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationWallController.repeat();
      }
      if (animationWallController.value.toInt() == 200) {
        debugPrint('touch');
      }
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }

      if (animationWallController.value == animationController.value) {
        animationWallController.dispose();
      }
      // debugPrint/(status.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(title: Text('Super Mario', style: TextStyle(fontFamily: 'SuperMario'), )),
      body: InkWell(
        onTap: () {
          animationController.forward();
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.875,
                  color: Colors.blue[100],
                  child: Column(
                    children: [
                      const Spacer(),
                      Divider(height:330, thickness: 7, indent: 1, endIndent: 3, color: Colors.black54,)
                    ],
                  ),
                ),
                Positioned(
                  bottom: animationController.value,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset('assets/images/mario.gif'),
                  ),
                ),
                Positioned(
                    right: animationWallController.value,
                    bottom: 160,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Image.asset('assets/images/flower.png', height: 400,),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();   
    animationController.dispose();
  }
}
