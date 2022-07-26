import 'package:flutter/material.dart';

import 'card/cover_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter animation example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const imageHeight = 278.0;
  final _controller = PageController(viewportFraction: 0.68);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xff254659),
      child: Column(
        children: [
          SizedBox(
            height: 520,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  height: 520,
                  child: SizedBox(
                    width: deviceWidth,
                    child: PageView.builder(
                      itemCount: 7,
                      controller: _controller,
                      itemBuilder: (_, i) {
                        return CoverCard(
                          pageController: _controller,
                          imageHeight: imageHeight,
                          index: i,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 26)
        ],
      ),
    );
  }
}
