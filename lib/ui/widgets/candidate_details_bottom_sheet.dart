import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/models/candidate.dart';
import 'package:voters/core/models/voter.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/voters/face_reg_screen.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';
import 'package:web3dart/web3dart.dart';

class CandidateDetailsBottomSheet extends StatefulWidget {
  const CandidateDetailsBottomSheet({
    Key key,
    this.isAdmin = false,
    this.candidate,
  }) : super(key: key);

  final bool isAdmin;
  final Candidate candidate;

  @override
  _CandidateDetailsBottomSheetState createState() =>
      _CandidateDetailsBottomSheetState();
}

class _CandidateDetailsBottomSheetState
    extends State<CandidateDetailsBottomSheet> {
  StorageService storageService;
  bool hasVoted;
  bool _isLoading = false;
  List<Voter> _votersLists = [];
  int _noOfVoters = 0;
  String _ethAddress;

  @override
  void initState() {
    super.initState();
    storageService = StorageService();
    checkVoteStatus();
  }

  checkVoteStatus() async {
    setState(() {
      _isLoading = true;
    });

    var resultList = await electionService.readContract(
      electionService.getTotalVoter,
      [],
    );
    _noOfVoters = int.parse(resultList.first.toString());
    log('get total votes $_noOfVoters');

    List _votersAddresses = [];

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('voters_addresses')
        .doc('addresses')
        .get();

    _votersAddresses = documentSnapshot.data()['data'];
    _ethAddress = await storageService.getAddress();

    log('voters addresses are $_votersAddresses');

    for (int i = 0; i < _noOfVoters; i++) {
      var result = await electionService.readContract(
        electionService.voterDetails,
        [
          // GET VOTER DETAILS BASED ON THEIR ADDRESSES
          EthereumAddress.fromHex(_votersAddresses[i].toString().toLowerCase()),
        ],
      );
      _votersLists.add(
        Voter(
          voterAddress: result[0].toString().toLowerCase(),
          name: result[1],
          phone: result[2],
          isVerified: result[3],
          hasVoted: result[4],
          hasRegistered: result[5],
        ),
      );
      log('voters list herrrrrrr $_votersLists');
      if (_votersLists[i].voterAddress == _ethAddress.toLowerCase()) {
        log('found ittt!!! ${_votersLists[i].hasVoted}');
        hasVoted = _votersLists[i].hasVoted;
        break;
      }
    }

    await _computeFurtherData();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _computeFurtherData() async {
    // hasVoted = await storageService.getVoteStatus();

    log('has voted is here $hasVoted');
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(.5),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      VotersTextField(
                        hintText: 'First Name',
                        labelText: 'First Name',
                        controller: TextEditingController(
                          text: widget.candidate.name.split(' ').first,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'Last Name',
                        labelText: 'Last Name',
                        controller: TextEditingController(
                          text: widget.candidate.name.split(' ').last,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'Email',
                        labelText: 'Email',
                        controller: TextEditingController(
                          text:
                              '${widget.candidate.name.split(' ').first.toLowerCase()}@${widget.candidate.name.split(' ').last.toLowerCase()}.com',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'Phone Number',
                        labelText: 'Phone Number',
                        controller: TextEditingController(
                          text: '08143037721',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'Gender',
                        labelText: 'Gender',
                        controller: TextEditingController(
                          text: 'Male',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'Date of Birth',
                        labelText: 'Date of Birth',
                        controller: TextEditingController(
                          text: '00/00/0000',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'State',
                        labelText: 'State',
                        controller: TextEditingController(
                          text: 'Osun State',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      VotersTextField(
                        hintText: 'LGA',
                        labelText: 'LGA',
                        controller: TextEditingController(
                          text: 'Lagelu LGA',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                if (!widget.isAdmin)
                  SizedBox(
                    height: 10,
                  ),
                if (!widget.isAdmin)
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: blackColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'You are about to vote for ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: widget.candidate.name.split(' ').first +
                                  ' ' +
                                  widget.candidate.name.split(' ').last,
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' for this election.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (!widget.isAdmin)
                  SizedBox(
                    height: 20,
                  ),
                if (!widget.isAdmin)
                  VotersFilledButton(
                    text:
                        '${hasVoted ? 'Voted' : 'Vote'} for ${widget.candidate.name.split(' ').first}  ${widget.candidate.name.split(' ').last}'
                            .toUpperCase(),
                    onPressed: () async {
                      showLoadingDialog(context);

                      // also check face befroe they vote
                      // bool result = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => VotersFaceRegScreen(),
                      //   ),
                      // );

                      // if (result) {
                      // face is verified
                      // vote

                      log('candidate id is ${widget.candidate.candidateId}');
                      if (!hasVoted) {
                        try {
                          var result = await electionService.writeContract(
                            electionService.vote,
                            [
                              BigInt.from(widget.candidate.candidateId),
                            ],
                          );

                          Navigator.pop(context);

                          setState(() {
                            hasVoted = true;
                          });

                          if (result != null) {
                            storageService.saveVoteStatus(true);
                          }
                        } catch (e) {
                          log('error is here $e');
                          Navigator.pop(context);

                          showErrorDialog(
                            context,
                            'You have not been verified!',
                          );
                        }
                      } else {
                        Navigator.pop(context);

                        showErrorDialog(
                          context,
                          'You have already voted for a candidate',
                        );
                      }
                      // } else {
                      //   // face not veirifed
                      //   showErrorDialog(
                      //     context,
                      //     'Face verification failed',
                      //   );
                      // }
                    },
                  ),
              ],
            ),
          );
  }
}
