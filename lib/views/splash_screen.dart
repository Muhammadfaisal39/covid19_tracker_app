import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid19_tracker_app/views/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WorldStates()));
    });
  }

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Center(
                      child: Image(
                        image: AssetImage('images/virus.png'),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText(
                  "Covid19\nTracker App",
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
