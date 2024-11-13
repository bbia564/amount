
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class StarWidget extends StatelessWidget {
  final double value;
  final Function(double) onChange;
  const StarWidget({
    super.key,
    required this.value,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: value,
      onValueChanged: (v) {
        onChange.call(v);
      },
      starBuilder: (index, color) {
        if (color == const Color(0xffffa700)) {
          return const Icon(Icons.star,size: 16,color: Color(0xffffa700),);
        }
        return const Icon(Icons.star,size: 16,color: Color(0xffdedede),);
      },
      starCount: 5,
      starSize: 16,
      maxValue: 5,
      starSpacing: 2,
      maxValueVisibility: false,
      valueLabelVisibility: false,
      animationDuration: const Duration(milliseconds: 500),
      starOffColor: Colors.transparent,
      starColor:const Color(0xffffa700),
    );
  }
}
