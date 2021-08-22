import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/elections/voter_elections_screen.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/profile/voter_profile_screen.dart';

class VoterBottomNav extends StatefulWidget {
  @override
  _VoterBottomNavState createState() => _VoterBottomNavState();
}

class _VoterBottomNavState extends State<VoterBottomNav> {
  PageController _pageController;

  final _bodyWidgets = [
    VoterElectionsScreen(),
    VoterProfileScreen(),
  ];

  int _currentIndex = 0;

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _currentIndex == 0 ? 'Elections' : 'Profile',
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (newIndex) {
            setState(() {});
            _currentIndex = newIndex;
            _pageController.animateToPage(
              _currentIndex,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.how_to_vote_rounded,
              ),
              label: 'Elections',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ..._bodyWidgets,
          ],
        ),
      ),
    );
  }
}
