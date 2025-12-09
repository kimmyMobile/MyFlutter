import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  static const _radiusBorderMenu = 16.0;
  static const _items = [
    ('assets/icons/home.svg', 'Home'),
    ('assets/icons/search.svg', 'Search'),
    ('assets/icons/center.svg', ''), // ตำแหน่งหลัก
    ('assets/icons/live.svg', 'Live'),
    ('assets/icons/profile.svg', 'Profile'),
  ];
  static const _indexMain = 2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(_radiusBorderMenu),
        topRight: Radius.circular(_radiusBorderMenu),
      ),
      child: BottomAppBar(
        elevation: 0,
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    const currentIndex = 0; // TODO: รับค่าจากภายนอกถ้าต้องการ
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: Theme.of(context).bottomNavigationBarTheme,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          _items.length,
          (index) => BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(Icons.home ,size: 22,),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(Icons.home ,size: 22,),
            ),
            label: _items[index].$2,
          ),
        ),
        currentIndex: currentIndex,
        onTap: (value) {
          // TODO: จัดการ navigation ภายนอก เช่น callback
          if (value == _indexMain) return;
        },
      ),
    );
  }
}