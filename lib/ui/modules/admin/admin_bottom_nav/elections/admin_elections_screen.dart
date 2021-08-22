import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/models/voter_admin.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/election_details_screen.dart';
import 'package:voters/ui/widgets/all_election_card.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/ui/widgets/upcoming_election.dart';

class AdminElectionsScreen extends StatefulWidget {
  const AdminElectionsScreen({Key key}) : super(key: key);

  @override
  _AdminElectionsScreenState createState() => _AdminElectionsScreenState();
}

class _AdminElectionsScreenState extends State<AdminElectionsScreen> {
  VoterAdmin _voterAdmin;
  bool _isLoading = false;
  ElectionService _electionService;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _pushToElectionDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminElectionDetailScreen(),
      ),
    );
  }

  String votingImage =
      'https://firebasestorage.googleapis.com/v0/b/voters-87247.appspot.com/o/voting.jpeg?alt=media&token=a80e0bd1-053a-4a9c-8cb7-702604f8ad4c';

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    // get private and public key from firebase
    await _getAdminKeyAndAddress();

    // get election status
    _electionService.readContract(_electionService.getStart, []);

    // if there is an election, get election details
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getAdminKeyAndAddress() async {
    FirebaseFirestore ff = FirebaseFirestore.instance;

    DocumentSnapshot document =
        await ff.collection('admin').doc('8BvyYNbx2AVxfZZXwA9JlB4jOLr1').get();

    _voterAdmin = VoterAdmin.fromJson(
      document.data(),
    );
    _electionService = ElectionService(_voterAdmin.privateKey);
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0).add(
              EdgeInsets.only(
                top: 15.0,
              ),
            ),
            child: Column(
              children: [
                VotersTextField(
                  hintText: 'Admin Address',
                  labelText: 'Admin Adress',
                  controller: TextEditingController(
                    text: _voterAdmin.address,
                  ),
                  readOnly: true,
                ),
                SizedBox(
                  height: 10,
                ),
                VotersTextField(
                  hintText: 'Admin Private Key',
                  labelText: 'Admin Private Key',
                  controller: TextEditingController(
                    text: _voterAdmin.privateKey,
                  ),
                  readOnly: true,
                ),
                SizedBox(
                  height: 10,
                ),
                VotersTextField(
                  hintText: 'ETH Balance',
                  labelText: 'ETH Balance',
                  controller: TextEditingController(
                    text: '500 ETH',
                  ),
                  readOnly: true,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'No Elections, create an election to by clicking the create button!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF62961D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SizedBox(
                //   height: 270,
                //   width: double.infinity,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     padding: EdgeInsets.symmetric(vertical: 10.0),
                //     children: [
                //       UpcomingElectionCard(
                //         onTap: _pushToElectionDetails,
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       UpcomingElectionCard(
                //         onTap: _pushToElectionDetails,
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       UpcomingElectionCard(
                //         onTap: _pushToElectionDetails,
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       UpcomingElectionCard(
                //         onTap: _pushToElectionDetails,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'All Elections',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //     color: Color(0xFF62961D),
                //   ),
                // ),
                // ListView.separated(
                //   shrinkWrap: true,
                //   primary: false,
                //   padding: EdgeInsets.symmetric(vertical: 10.0),
                //   itemBuilder: (_, __) {
                //     return AllElectionCard(
                //       onTap: _pushToElectionDetails,
                //     );
                //   },
                //   separatorBuilder: (_, __) {
                //     return SizedBox(
                //       height: 15,
                //     );
                //   },
                //   itemCount: 12,
                // ),
              ],
            ),
          );
  }
}
