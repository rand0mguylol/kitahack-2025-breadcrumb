import 'package:flutter/material.dart';

class GoalListTile extends StatelessWidget {
  const GoalListTile(
      {super.key,
      required this.text,
      required this.isCompleted,
      required this.onTap});

  final String text;
  final bool isCompleted;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(204, 255, 172, 64),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                isCompleted
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: onTap,
                        child: Text(
                          'Check goal completion',
                          style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
              ],
            ),
          ),
          isCompleted
              ? Container(
                  width: 30,
                  height: 30,
                  child: const Icon(Icons.check_circle_outline,
                      color: Colors.white, size: 30),
                )
              : Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                )
        ],
      ),
    );
  }
}

dynamic getValueFromMap(Map<String, dynamic> map, String keyPath) {
  // Split the keyPath into parts using the "." delimiter
  List<String> keys = keyPath.split('.');

  // Traverse the map step by step
  dynamic current = map;
  for (String key in keys) {
    if (current is Map<String, dynamic> && current.containsKey(key)) {
      current = current[key];
    } else {
      // Return null if the key does not exist
      return null;
    }
  }

  return current; // Return the final value
}
