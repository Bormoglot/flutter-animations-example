import 'dart:math';

import 'package:flutter/material.dart';

import 'card_image.dart';

class CoverCard extends StatefulWidget {
  const CoverCard({
    Key? key,
    required this.index,
    required this.pageController,
    required this.imageHeight,
  }) : super(key: key);

  final int index;
  final PageController pageController;
  final double imageHeight;

  @override
  _CoverCardState createState() => _CoverCardState();
}

class _CoverCardState extends State<CoverCard> {
  static const double _defaultArrowOffset = .0;
  static const double _focusArrowOffset = 40;
  static const cardPadding = 111.0;

  final ValueNotifier<double> _scrollPosition = ValueNotifier<double>(0.0);

  void _onScrollPositionChanged() {
    setState(() => _scrollPosition.value = widget.pageController.page ?? 0.0);
  }

  double _getArrowOffset() {
    final scrollPosition = _scrollPosition.value;
    final currentPosition = scrollPosition.floor();

    final delta = scrollPosition - currentPosition;

    final forwardAnimationOffest =
        Curves.ease.transform(1 - delta) * _focusArrowOffset;
    final backwardAnimationOffest =
        Curves.ease.transform(delta) * _focusArrowOffset;

    var animatedArrowOffset = _defaultArrowOffset;

    if (widget.index == currentPosition) {
      /// Closest to focus
      animatedArrowOffset = forwardAnimationOffest;
    } else if (widget.index == currentPosition + 1) {
      /// Left or right sided from central card
      animatedArrowOffset = backwardAnimationOffest;
    }

    return animatedArrowOffset;
  }

  double getTextOpacity() {
    final scrollPosition = _scrollPosition.value;
    final currentPosition = scrollPosition.floor();
    final delta = scrollPosition - currentPosition;

    if (widget.index == currentPosition) return 1 - delta;

    if (currentPosition + 1 == widget.index) return delta;

    return 0;
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_onScrollPositionChanged);
  }

  @override
  void dispose() {
    super.dispose();
    widget.pageController.removeListener(_onScrollPositionChanged);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final width = deviceWidth * 0.68;
    final widthCard = deviceWidth * 0.48;
    final heightCard = widthCard * 1.4;

    final arrowPadding =
        widget.imageHeight / 2 + (heightCard + cardPadding) / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: cardPadding,
          child: PhysicalModel(
            color: Colors.black,
            shadowColor: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
            elevation: 12,
            child: CardImage(
              height: heightCard,
              width: widthCard,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _scrollPosition,
          builder: (BuildContext context, Widget? child) {
            return Positioned(
              top: arrowPadding - 33,
              left: widthCard + _getArrowOffset(),
              child: Transform.rotate(
                angle: pi / 2.0,
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/arrow_insider.png',
                  ),
                  color: Color(0xfff9b9ad),
                  size: 62,
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _scrollPosition,
          builder: (BuildContext context, Widget? child) {
            return Positioned(
              width: width,
              top: heightCard + 85,
              child: Opacity(
                opacity: getTextOpacity(),
                child: Column(
                  children: [
                    Text(
                      "Jane Doe",
                      textAlign: TextAlign.center,
                      style: _titleTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Lorem ipsum dolor sit amet",
                      textAlign: TextAlign.center,
                      style: _subtitleTextStyle,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  final _titleTextStyle = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 40,
    height: 1.1,
    decoration: TextDecoration.none,
    letterSpacing: 0.25,
    wordSpacing: 0.25,
    color: Colors.white,
  );

  final _subtitleTextStyle = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 15,
    height: 1.47,
    decoration: TextDecoration.none,
    letterSpacing: -0.24,
    wordSpacing: -0.24,
    color: Colors.white,
  );
}
