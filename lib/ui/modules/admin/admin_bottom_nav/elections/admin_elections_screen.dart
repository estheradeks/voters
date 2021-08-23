import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/voter_admin.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/elections/election_details_screen.dart';
import 'package:voters/ui/widgets/all_election_card.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
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
  bool _hasElectionStarted;
  bool _hasElectionEnded;
  String electionTitle = '';
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _pushToElectionDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminElectionDetailScreen(
          electionName: electionTitle,
        ),
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
    var resultListStart = await electionService.readContract(
      electionService.getStart,
      [],
    );
    _hasElectionStarted = resultListStart.first;
    var resultListEnd = await electionService.readContract(
      electionService.getEnd,
      [],
    );
    _hasElectionEnded = resultListEnd.first;

    // if there is an election, get election details
    if (_hasElectionStarted) {
      var results = await electionService.readContract(
        electionService.getElectionTitle,
        [],
      );
      electionTitle = results.first;
    }
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
            child: SingleChildScrollView(
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
                      text: '928.29 ETH',
                    ),
                    readOnly: true,
                  ),
                  if (_hasElectionStarted)
                    SizedBox(
                      height: 40,
                    ),
                  if (_hasElectionStarted)
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ongoing Election',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          UpcomingElectionCard(
                            onTap: _pushToElectionDetails,
                            electionName: electionTitle,
                          ),
                        ],
                      ),
                    ),
                  if (_hasElectionEnded)
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Election Ended',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          UpcomingElectionCard(
                            onTap: _pushToElectionDetails,
                            electionName: electionTitle,
                          ),
                        ],
                      ),
                    ),
                  if (!_hasElectionStarted && !_hasElectionEnded)
                    Expanded(
                      child: Center(
                        child: Text(
                          'No Election, create an election by clicking the create button!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF62961D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                  if (_hasElectionStarted)
                    VotersFilledButton(
                      text: 'END ELECTION',
                      onPressed: () async {
                        showLoadingDialog(context);
                        var result = await electionService.writeContract(
                          electionService.endElection,
                          [],
                        );

                        Navigator.pop(context);

                        if (result != null) {
                          showSuccessDialog(context, 'Election Ended');
                          _hasElectionEnded = true;
                          _hasElectionStarted = false;
                        }
                      },
                    ),

                  SizedBox(
                    height: 30,
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
            ),
          );
  }
}
