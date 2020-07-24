import 'package:flutter/material.dart';
import 'package:recipedia/Pages/App/Browse.dart';
import 'package:recipedia/Pages/App/Liked.dart';
import 'package:recipedia/Pages/App/Search.dart';
import 'package:recipedia/widgets/navbar.dart';

class AppHome extends StatefulWidget {
  AppHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with TickerProviderStateMixin {
 
  int _index = 0;
  TabController _tabController;
  AnimationController _animationController;

  final List<Widget> _listTabs = [
    Browse(),
    Search(), // CHANGE TO SEARCH
    LikedRecipes()
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _listTabs.length);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.reverse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipedia",
          style: TextStyle(
              fontSize: 36, color: Color(0xff262a46), fontFamily: 'RobotoMono'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      //If you want to show body behind the navbar, it should be true
      extendBody: true,
      // body: Center(),
      body: TabBarView(
          children: _listTabs,
          controller: _tabController,
          physics: NeverScrollableScrollPhysics()),
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Color(0xff262a46),
        selectedBackgroundColor: Colors.redAccent,
        itemBorderRadius: 40,
        selectedItemColor: Colors.white,
        borderRadius: 40,
        onTap: (int val) {
          setState(() {
            _index = val;
            _tabController.animateTo(_index);
            _animationController.reverse();
          });
        },
        currentIndex: _index,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.search, title: 'Search'),
          FloatingNavbarItem(
              icon: Icons.favorite_border, title: 'Liked Recipes'),
        ],
      ),
    );
  }
}
