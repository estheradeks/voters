import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/admin_elections_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/create_election_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/profile/admin_profile_screen.dart';
import 'package:voters/ui/results/election_results_screen.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  PageController _pageController;
  bool _showElectionFab = false;

  final _bodyWidgets = [
    AdminElectionsScreen(),
    ElectionResultsScreen(),
    AdminProfileScreen(),
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
        floatingActionButton: _currentIndex == 0
            ? _showElectionFab
                ? FloatingActionButton.extended(
                    onPressed: () async {
                      var result = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                        ),
                        builder: (context) {
                          return CreateElectionScreen();
                        },
                      );
                    },
                    label: Text(
                      'Create Election',
                    ),
                    icon: Icon(
                      Icons.how_to_vote,
                    ),
                  )
                : SizedBox.shrink()
            : SizedBox.shrink(),
        appBar: AppBar(
          title: Text(
            _currentIndex == 0
                ? 'Elections'
                : _currentIndex == 1
                    ? 'Results'
                    : 'Profile',
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
                Icons.ballot_rounded,
              ),
              label: 'Results',
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
