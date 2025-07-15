import 'package:flutter/material.dart';
import 'package:pratical_flutter/pages/home_page.dart';
import 'package:pratical_flutter/pages/profile_pages.dart';
import 'package:pratical_flutter/pages/save_pages.dart';
import 'package:pratical_flutter/pages/search_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedPageIndex = 0;
  final List _pages = [HomePage(), SearchPage(), SavePages(), ProfilePages()];

  void _onNavigatorToggle(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  bool _activeAppBar() {
    return _selectedPageIndex == 2 || _selectedPageIndex == 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _activeAppBar() ? _buildAppBar() : null,
      body: SafeArea(child: _pages[_selectedPageIndex]),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 0.2,
      centerTitle: true,
      title: Text(
        _selectedPageIndex > 1
            ? _selectedPageIndex == 2
                  ? 'Công thức'
                  : 'Trang cá nhân'
            : '',
        style: TextStyle(
          color: Color(0xFFA47804),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        onPressed: () => _onNavigatorToggle(0),
        icon: Icon(Icons.arrow_back, color: Color(0xFFA47804)),
      ),
      actions: [
        IconButton(
          onPressed: () => print('More'),
          icon: Icon(Icons.more_vert, color: Color(0xFFA47804)),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        onPressed: () {
          print("FAB tapped!");
        },
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Icon(Icons.add, size: 40, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withAlpha(30),
            blurRadius: 10,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: BottomAppBar(
        height: 60,
        shape: CircularNotchedRectangle(),
        notchMargin: 15.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                _bottomButtonIcon(icon: Icons.home, index: 0),
                const SizedBox(width: 20),
                _bottomButtonIcon(icon: Icons.search, index: 1),
              ],
            ),
            Row(
              children: [
                _bottomButtonIcon(
                  icon: Icons.bookmark_border_outlined,
                  index: 2,
                ),
                const SizedBox(width: 20),
                _bottomButtonIcon(icon: Icons.person, index: 3),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtonIcon({required IconData icon, required int index}) {
    final isSelected = index == _selectedPageIndex;
    return IconButton(
      onPressed: () => _onNavigatorToggle(index),
      icon: Icon(icon, color: isSelected ? Color(0xFFCEA700) : Colors.blueGrey),
    );
  }
}
