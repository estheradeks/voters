import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/admin_elections_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/create_election_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/profile/admin_profile_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/voters/admin_voters_screen.dart';
import 'package:voters/ui/results/election_results_screen.dart';
import 'package:voters/ui/widgets/dialogs.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  PageController _pageController;
  bool _showElectionFab = true;

  final _bodyWidgets = [
    AdminElectionsScreen(),
    AdminVotersScreen(),
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
                      showLoadingDialog(context);
                      String privateKey =
                          await StorageService().getPrivateKey();

                      ElectionService electionService =
                          ElectionService(privateKey);
                      await electionService.initialSetup();
                      var resultList = await electionService.readContract(
                        electionService.getStart,
                        [],
                      );
                      Navigator.pop(context);

                      if (resultList.first) {
                        showErrorDialog(
                            context, 'An election has already started');
                      } else {
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
                      }
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
                    ? 'Voters'
                    : _currentIndex == 2
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
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.how_to_vote_rounded,
              ),
              label: 'Elections',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_rounded,
              ),
              label: 'Voters',
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
