//import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:grocden/tabs/home_tab.dart';
import 'package:grocden/tabs/shops_tab.dart';

import '../tabs/notifications_tab.dart';
import '../tabs/orders_tab.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        backgroundColor: Colors.green,
          icon: new Icon(Icons.home_outlined, size: 35,),
          label: 'Red'
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.green,
          icon: Icon(Icons.store_mall_directory_outlined, size: 35,),
          label: 'Shops'
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.green,
        icon: new Icon(Icons.shopping_bag_outlined, size: 35,),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.green,
          icon: new Icon(Icons.notifications_none, size: 35),
          label: 'Notifications'
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
        ),
        Scaffold(
         body: ShopTab(),
        ),
        Scaffold(
          body: OrdersTab(),
        ),
        Scaffold(
          body: NotificationsTab(),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff403b58),
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}