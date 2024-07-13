import 'dart:ui';

import 'package:flutter/material.dart';

class ExplicitAnimationsPage extends StatefulWidget {
  const ExplicitAnimationsPage({super.key});

  @override
  State<ExplicitAnimationsPage> createState() => _ExplicitAnimationsPageState();
}

class _ExplicitAnimationsPageState extends State<ExplicitAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      duration: Durations.medium4,
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: Durations.extralong4,
    )..repeat();
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 5,
    ).animate(
      CurvedAnimation(
        parent: _animationController1,
        curve: Curves.easeOutBack,
      ),
    );

    _blurAnimation = Tween<double>(
      begin: 0.01,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _animatedContainerExample(),
          _animatedBuilderExample(),
          // const Text('test'),
        ],
      ),
    );
  }

  Widget _animatedContainerExample() {
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              height: 50,
              width: 50,
              color: Colors.red,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  _animationController1.forward();
                },
                child: const Text('Forward'),
              ),
              MaterialButton(
                onPressed: () {
                  _animationController1.reverse();
                },
                child: const Text('Reverse'),
              ),
              MaterialButton(
                onPressed: () {
                  _animationController1.stop();
                },
                child: const Text('Stop'),
              ),
              MaterialButton(
                onPressed: () {
                  _animationController1.reset();
                },
                child: const Text('Reset'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _animatedBuilderExample() {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, child) {
        return SizedBox(
          height: 200,
          width: 200,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: _blurAnimation.value * 40,
              sigmaY: _blurAnimation.value * 40,
            ),
            child: child,
          ),
        );
      },
      child: const Image(
        image: NetworkImage(
          'https://images.pexels.com/photos/26100664/pexels-photo-26100664/free-photo-of-a-young-male-deer.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load',
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
