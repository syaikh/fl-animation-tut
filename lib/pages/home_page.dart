import 'package:flutter/material.dart';
import 'package:myapp/pages/explicit_animations_page.dart';
import 'package:myapp/pages/implicit_animations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Implicit Animations',
              ),
              Tab(
                text: 'Explicit Animations',
              ),
            ]),
          ),
          body: const TabBarView(
            children: [
              ImplicitAnimationsPage(),
              ExplicitAnimationsPage(),
            ],
          ),
        ));
  }
}
