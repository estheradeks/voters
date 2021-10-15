import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/elections/election_details_screen.dart';
import 'package:voters/ui/widgets/all_election_card.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/ui/widgets/upcoming_election.dart';
import 'package:voters/utils/theme.dart';

class VoterElectionsScreen extends StatefulWidget {
  @override
  _VoterElectionsScreenState createState() => _VoterElectionsScreenState();
}

class _VoterElectionsScreenState extends State<VoterElectionsScreen> {
  bool _isLoading = false;
  bool _hasElectionStarted;
  bool _hasElectionEnded;
  String electionTitle = '';
  String votingImage =
      'https://firebasestorage.googleapis.com/v0/b/voters-87247.appspot.com/o/voting.jpeg?alt=media&token=a80e0bd1-053a-4a9c-8cb7-702604f8ad4c';
  String voterAddress = '';
  String voterPrivateKey = '';
  ElectionService electionService;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    // get private and public key from firebase
    await _getKeyAndAddress();
    electionService = ElectionService(voterPrivateKey);
    await electionService.initialSetup();

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

  Future<void> _getKeyAndAddress() async {
    StorageService storageService = StorageService();

    voterAddress = await storageService.getAddress();
    voterPrivateKey = await storageService.getPrivateKey();
  }

  void _pushToElectionDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VoterElectionDetailsScreen(
          electionTitle: electionTitle,
        ),
      ),
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
            child: Column(
              children: [
                VotersTextField(
                  hintText: 'Voter Address',
                  labelText: 'Voter Adress',
                  controller: TextEditingController(
                    text: voterAddress,
                  ),
                  readOnly: true,
                ),
                SizedBox(
                  height: 10,
                ),
                VotersTextField(
                  hintText: 'Voter Private Key',
                  labelText: 'Voter Private Key',
                  controller: TextEditingController(
                    text: voterPrivateKey,
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
                    text: '978.18 ETH',
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
                        'No Election, you can see an election here when it has been created!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF62961D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
          );
  }
}
