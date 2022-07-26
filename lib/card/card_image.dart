import 'package:flutter/material.dart';

const borderRadius = BorderRadius.all(Radius.circular(12.0));

class CardImage extends StatelessWidget {
  final double height;
  final double width;

  const CardImage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: borderRadius,
          color: Color(0xff254659),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                0.5012,
                0.999,
              ],
              colors: [
                Color.fromRGBO(0, 0, 0, 0.1),
                Color.fromRGBO(0, 0, 0, 0.2),
                Color.fromRGBO(0, 0, 0, 0.4),
              ],
            ),
          ),
          child: const Align(
            child: SizedBox(
              child: ImageIcon(
                AssetImage('assets/icons/arrow_insider.png'),
                color: Color(0xfff9b9ad),
                size: 40,
                semanticLabel: 'arrow insider',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
