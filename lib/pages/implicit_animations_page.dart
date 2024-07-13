import 'dart:ui';

import 'package:flutter/material.dart';

class ImplicitAnimationsPage extends StatefulWidget {
  const ImplicitAnimationsPage({super.key});

  @override
  State<ImplicitAnimationsPage> createState() => _ImplicitAnimationsPageState();
}

class _ImplicitAnimationsPageState extends State<ImplicitAnimationsPage> {
  bool trigger = false;
  double blurValue = 0.01;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _animatedContainerExample(),
          _tweenAnimatedBuilderExample(),
        ],
      ),
    );
  }

  Widget _animatedContainerExample() {
    return Column(
      children: [
        AnimatedContainer(
          duration: Durations.extralong4,
          height: 300,
          width: 300,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
              color: trigger ? Colors.yellow : Colors.pink,
              border: Border.all(
                color: trigger ? Colors.green : Colors.orange,
                width: 20,
              )),
        ),
        MaterialButton(
          onPressed: () {
            setState(() {
              trigger = !trigger;
            });
          },
          child: const Text('Trigger'),
        ),
      ],
    );
  }

  Widget _tweenAnimatedBuilderExample() {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 0.01,
              end: blurValue,
            ),
            duration: Durations.extralong4,
            builder: (context, value, child) {
              // print(value);
              return SizedBox(
                height: 200,
                width: 200,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: value,
                    sigmaY: value,
                  ),
                  child: child!,
                ),
              );
            },
            child: const Image(
                    image: NetworkImage(
                      'https://images.pexels.com/photos/26100664/pexels-photo-26100664/free-photo-of-a-young-male-deer.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load',
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          Slider(
            value: blurValue,
            min: 0.01,
            max: 10,
            onChanged: (value) {
              setState(() {
                blurValue = value;
              });
            },
          )
        ],
      ),
    );
  }
}
