import 'dart:ffi';

import 'package:e_commer/pages/cart/cart_history.dart';
import 'package:e_commer/pages/home/main_food_page.dart';
import 'package:e_commer/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  /*void onTabNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  List pages=[
    MainFoodPage(),
    Container(
      child: Center(
        child: Text("Next Page") 
        ),
    ),
    Container(
      child: Center(
        child: Text("Next Page 1") 
        ),
    ),
    Container(
      child: Center(
        child: Text("Next Page 2") 
        ),
    ),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.yellowColor,
        showSelectedLabels: false,
        selectedFontSize: 0.0,
        showUnselectedLabels: false,
        unselectedFontSize: 0.0,
        selectedItemColor: AppColors.mainColor,
        onTap: onTabNav,
        currentIndex: _selectedIndex,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Me"
          ),

        ],
      )
      
      );

  
  }*/

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: Center(child: Text("Next Page")),
      ),
      // Container(
      //   child: Center(
      //    child: Text("Next Page 1")
      //    ),
      //),
      CartHistory(),
      Container(
        child: Center(child: Text("Next Page 2")),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.archive),
          title: ("History"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart),
          title: ("Cart"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Me"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
