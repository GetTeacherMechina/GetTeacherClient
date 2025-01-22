import "package:flutter/material.dart";

class StarWidget extends StatelessWidget {
  StarWidget({required this.onChanged, required this.rating});

  final void Function(int) onChanged;
  final int rating;

  Widget buildStar(final BuildContext context, final int index) => IconButton(
        onPressed: () {
          onChanged(index + 1);
        },
        icon: Icon(
          index + 1 > rating ? Icons.star_border : Icons.star,
          color: index + 1 > rating ? Colors.grey : Colors.yellow,
        ),
        iconSize: 64,
      );

  @override
  Widget build(final BuildContext context) => Row(
        children: List<Widget>.generate(
          5,
          (final int index) => buildStar(context, index),
        ),
        mainAxisAlignment: MainAxisAlignment.center,
      );
}
