import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final bool? isBlankBackground;
  final PreferredSizeWidget? bottom;
  final bool isBackButtonRight;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.isBlankBackground,
    this.leading,
    this.bottom, // Add this line
    this.size = 20,
    this.backgroundColor = Colors.black, // Default background color
    this.textColor = Colors.white, // Default text color
    this.isBackButtonRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: <Color>[
      //         Color.fromRGBO(97, 0, 255, 1),
      //         Colors.transparent // #844FAB
      //       ],
      //     ),
      //   ),
      // ),

      title: Text(
        title ?? '',
        style: TextStyle(color: textColor, fontSize: size),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      bottom: bottom, // Set the bottom property to the TabBar
      leading: isBackButtonRight
          ? null
          : leading, // If isBackButtonRight is true, don't set leading
      // actions: isBackButtonRight
      //     ? [leading!]
      //     : actions, // If isBackButtonRight is true, set leading as the first action
      actions: actions,
      backgroundColor: isBlankBackground == true
          ? Colors.transparent
          : Theme.of(context)
              .colorScheme
              .primary, // Make AppBar background transparent to view gradient
    );
  }

  @override
  Size get preferredSize {
    // Calculate the height dynamically based on whether there's a bottom widget.
    final double bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}


/*** "Use guide"
        appBar: DefaultAppBar(
          title: 'Title',

          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add onPressed action for search button
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Add onPressed action for settings button
              },
            ),
          ],

          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add onPressed action for menu button
            },
          ),

        ),//Appbar

***/