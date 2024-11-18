import 'package:flutter/material.dart';

class AnimatedNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  _AnimatedNavigationBarState createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.home,
              color: widget.currentIndex == 0 ? Colors.red : Colors.white60,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.search,
              color: widget.currentIndex == 1 ? Colors.red : Colors.white60,
            ),
          ),
          label: 'Search',
        ),
      ],
    );
  }
}
