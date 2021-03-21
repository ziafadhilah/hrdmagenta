import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/Account/Account.dart';
import 'package:hrdmagenta/page/employee/Home/home.dart';
import 'package:hrdmagenta/page/notification/notif.dart';
import 'package:hrdmagenta/utalities/color.dart';

class NavBarEmployee extends StatefulWidget {
  @override
  _NavBarEmployeeState createState() => _NavBarEmployeeState();
}

class _NavBarEmployeeState extends State<NavBarEmployee> {

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeEmployee(),
            // HistoryEmployee(),
            Notifpage(),
            AccountEmployee()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: baseColor,
              inactiveColor: Colors.black38,
              title: Text('Home',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: Icon(Icons.home)
          ),
          // BottomNavyBarItem(
          //     activeColor: Colors.redAccent[100],
          //   inactiveColor: Colors.black,
          //     title: Text('History'),
          //     icon: Icon(Icons.history)
          // ),
          BottomNavyBarItem(
              activeColor: baseColor,
              inactiveColor: Colors.black38,
              title: Text('Notification',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: Icon(Icons.notification_important_rounded)
          ),
          BottomNavyBarItem(
              activeColor: baseColor,
              inactiveColor: Colors.black38,
              title: Text('Account',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              icon: Icon(Icons.person)
          ),
        ],
      ),
    );
  }
}