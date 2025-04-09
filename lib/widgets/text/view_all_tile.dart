import 'package:flutter/material.dart';

class ViewAllTile extends StatelessWidget {
  const ViewAllTile(
      {super.key, required this.title, required this.onTap, this.hide = true});

  final String title;
  final GestureTapCallback onTap;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 14),
        ),
        hide == true
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: onTap,
                child: const Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                      fontSize: 12),
                ),
              )
      ],
    );
  }
}
