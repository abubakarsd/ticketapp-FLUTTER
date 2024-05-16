import 'package:flutter/material.dart';
import 'package:ticketapp/pages/mainpage/events.dart';
import 'package:ticketapp/pages/mainpage/home.dart';
import 'package:ticketapp/pages/mainpage/profile.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Center(child: Text('data2')),
    const Center(child: Text('data3')),
    const MyEvents(),
    ProfilePage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      // Ensure that index is within the valid range
      _selectedIndex = index.clamp(0, _widgetOptions.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: Container(
          height: screenHeight * 0.099,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.1,
              color: Colors.black,
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
            selectedItemColor: const Color(0xFF127CF7),
            unselectedItemColor: Colors.black,
            type:
                BottomNavigationBarType.fixed, // Ensure labels are always shown
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorites',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.event_available),
                label: 'My Events',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 4
                    ? Image.asset('assets/images/active_circle.png')
                    : Image.asset('assets/images/circle.png'),
                label: 'My Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}