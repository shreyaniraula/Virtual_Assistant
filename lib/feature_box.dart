import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox({
    super.key,
    required this.headerText,
    required this.descriptionText,
    required this.boxColor,
  });

  final String headerText;
  final String descriptionText;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              headerText,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cera Pro',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              descriptionText,
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: 'Cera Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
