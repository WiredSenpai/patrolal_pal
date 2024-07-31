import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  const SquareTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200]),
        child: IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.google),
          iconSize: 42,
        ),
      ),
    );
  }
}
