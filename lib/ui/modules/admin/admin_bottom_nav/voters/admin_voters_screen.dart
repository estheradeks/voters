import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/voter.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/election_candidates_card.dart';
import 'package:voters/ui/widgets/voter_card.dart';
import 'package:voters/utils/theme.dart';
import 'package:web3dart/credentials.dart';

class AdminVotersScreen extends StatefulWidget {
  @override
  _AdminVotersScreenState createState() => _AdminVotersScreenState();
}

class _AdminVotersScreenState extends State<AdminVotersScreen> {
  bool _hasElectionStarted;
  bool _hasElectionEnded;
  bool _isLoading = false;
  int _noOfVoters = 0;
  List<Voter> _votersLists = [];
  String _address;
  String role;
  ElectionService electionService;

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    _address = await StorageService().getAddress();
    String privateKey = await StorageService().getPrivateKey();
    role = await StorageService().getRole();

    electionService = ElectionService(privateKey);
    await electionService.initialSetup();

    // get election start value
    var resultListStart = await electionService.readContract(
      electionService.getStart,
      [],
    );
    _hasElectionStarted = resultListStart.first;

    // get election end value
    var resultListEnd = await electionService.readContract(
      electionService.getEnd,
      [],
    );
    _hasElectionEnded = resultListEnd.first;

    // get candidates
    var resultList = await electionService.readContract(
      electionService.getTotalVoter,
      [],
    );
    _noOfVoters = int.parse(resultList.first.toString());
    log('get total votes $_noOfVoters');

    // get the voters addresses from Firebase
    List _votersAddresses = [];

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('voters_addresses')
        .doc('addresses')
        .get();

    _votersAddresses = documentSnapshot.data()['data'];

    log('voters addresses are $_votersAddresses');

    for (int i = 0; i < _noOfVoters; i++) {
      var result = await electionService.readContract(
        electionService.voterDetails,
        [
          // GET VOTER DETAILS BASED ON THEIR ADDRESSES
          EthereumAddress.fromHex(_votersAddresses[i]),
        ],
      );
      _votersLists.add(
        Voter(
          voterAddress: result[0].toString(),
          name: result[1],
          phone: result[2],
          isVerified: result[3],
          hasVoted: result[4],
          hasRegistered: result[5],
        ),
      );
    }

    _votersLists = _votersLists..sort((a, b) => b.name.compareTo(a.name));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            children: [
              if (_hasElectionStarted)
                Text(
                  'Election is Ongoing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              if (_hasElectionEnded)
                Text(
                  'Election has Ended',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              if (!_hasElectionStarted && !_hasElectionStarted)
                Text(
                  'Election has not Started',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF62961D),
                  ),
                ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'All Voters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: blackColor.withOpacity(.5),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    _votersLists.length.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!_hasElectionStarted && !_hasElectionStarted)
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      'The election has not started, please wait...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (_hasElectionStarted || _hasElectionEnded)
                ...List.generate(
                  _votersLists.length,
                  (index) => Column(
                    children: [
                      VotersCard(
                        positionSN: index + 1,
                        voter: _votersLists[index],
                        onTap: role == 'admin'
                            ? () async {
                                var res = await showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Verify Voter',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          VotersOutlinedButton(
                                            text: _votersLists[index].isVerified
                                                ? 'VOTER VERIFIED'
                                                : 'VERIFY VOTER',
                                            onPressed: () async {
                                              if (!_votersLists[index]
                                                  .isVerified) {
                                                showLoadingDialog(context);
                                                var result =
                                                    await electionService
                                                        .writeContract(
                                                  electionService.verifyVoter,
                                                  [
                                                    true,
                                                    EthereumAddress.fromHex(
                                                      _votersLists[index]
                                                          .voterAddress,
                                                    ),
                                                  ],
                                                );

                                                Navigator.pop(context);
                                                Navigator.pop(
                                                    context, result != null);

                                                if (result != null) {
                                                  showSuccessDialog(context,
                                                      'Voter verification successful!');
                                                } else {
                                                  showErrorDialog(context,
                                                      'Voter verification successful!');
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                if (res != null) {
                                  _votersLists[index].isVerified = true;
                                  setState(() {});
                                }
                              }
                            : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}
