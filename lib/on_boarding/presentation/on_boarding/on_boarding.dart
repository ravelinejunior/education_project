import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education App')),
      body: Column(
        children: [
          const Center(
            child: Text('Hello World!'),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text('Educational plan'),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Start'),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Continue'),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Click me')),
        ],
      ),
    );
  }
}
